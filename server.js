require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const { Pool } = require('pg');
const bcrypt = require('bcryptjs');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files from React build directory
app.use(express.static(path.join(__dirname, 'build')));

// PostgreSQL Connection Pool (for Supabase)
const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'postgres',
  port: 5432,
  ssl: { rejectUnauthorized: false } // Required for Supabase
});

// Health Check
app.get('/api/health', (req, res) => {
  res.json({ status: 'API is running' });
});

// ===================== AUTH ENDPOINTS =====================

// Login Endpoint
app.post('/api/login.php', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.json({ status: 0, message: 'Invalid input data' });
    }

    const result = await pool.query(
      'SELECT id, name, email, password, role FROM users WHERE email = $1',
      [email]
    );

    if (result.rows.length === 0) {
      return res.json({ status: 0, message: 'Invalid email or password' });
    }

    const user = result.rows[0];
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      return res.json({ status: 0, message: 'Invalid email or password' });
    }

    res.json({
      status: 1,
      message: 'Login successful',
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Register Endpoint
app.post('/api/users.php', async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    if (!name || !email || !password || !role) {
      return res.json({ status: 0, message: 'All fields are required' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      'INSERT INTO users (name, email, password, role) VALUES ($1, $2, $3, $4) RETURNING id, name, email, role',
      [name, email, hashedPassword, role]
    );

    res.json({ 
      status: 1, 
      message: 'User registered successfully',
      user: result.rows[0]
    });
  } catch (error) {
    console.error('Registration error:', error);
    if (error.code === '23505') {
      res.json({ status: 0, message: 'Email already exists' });
    } else {
      res.json({ status: 0, message: 'Error: ' + error.message });
    }
  }
});

// ===================== JOB ENDPOINTS =====================

// Get Jobs
app.get('/api/jobs.php', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM jobs WHERE status = $1 ORDER BY created_at DESC', ['active']);
    res.json(result.rows);
  } catch (error) {
    console.error('Get jobs error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Post Job
app.post('/api/post_job.php', async (req, res) => {
  try {
    const { title, company_name, location, salary, job_type, description, requirements, poster_email } = req.body;

    if (!title || !company_name || !poster_email) {
      return res.json({ status: 0, message: 'Required fields missing' });
    }

    const result = await pool.query(
      'INSERT INTO jobs (title, company_name, location, salary, job_type, description, requirements, poster_email, status) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *',
      [title, company_name, location, salary, job_type, description, requirements, poster_email, 'active']
    );

    res.json({ status: 1, message: 'Job posted successfully', job: result.rows[0] });
  } catch (error) {
    console.error('Post job error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// ===================== APPLICATION ENDPOINTS =====================

// Apply for Job
app.post('/api/apply_job.php', async (req, res) => {
  try {
    const { user_name, user_email, job_title, company_name, poster_email, job_id, resume_path } = req.body;

    if (!user_email || !job_id || !poster_email) {
      return res.json({ status: 0, message: 'Required fields missing' });
    }

    const result = await pool.query(
      'INSERT INTO applications (user_name, user_email, job_title, company_name, poster_email, job_id, resume_path, status) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *',
      [user_name, user_email, job_title, company_name, poster_email, job_id, resume_path, 'pending']
    );

    res.json({ status: 1, message: 'Application submitted successfully', application: result.rows[0] });
  } catch (error) {
    console.error('Apply job error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Get Applications for Job Seeker
app.get('/api/applications.php', async (req, res) => {
  try {
    const { user_email } = req.query;

    if (!user_email) {
      return res.json({ status: 0, message: 'User email is required' });
    }

    const result = await pool.query(
      'SELECT * FROM applications WHERE user_email = $1 ORDER BY created_at DESC',
      [user_email]
    );

    res.json({ status: 1, applications: result.rows });
  } catch (error) {
    console.error('Get applications error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Get Applications for Job Poster
app.get('/api/get_applications.php', async (req, res) => {
  try {
    const { poster_email } = req.query;

    if (!poster_email) {
      return res.json({ status: 0, message: 'Poster email is required' });
    }

    const result = await pool.query(
      'SELECT * FROM applications WHERE poster_email = $1 ORDER BY created_at DESC',
      [poster_email]
    );

    res.json({ status: 1, applications: result.rows });
  } catch (error) {
    console.error('Get applications error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Update Application Status
app.post('/api/update_application_status.php', async (req, res) => {
  try {
    const { id, status } = req.body;

    if (!id || !status) {
      return res.json({ status: 0, message: 'Invalid input data' });
    }

    const result = await pool.query(
      'UPDATE applications SET status = $1, updated_at = NOW() WHERE id = $2 RETURNING *',
      [status, id]
    );

    if (result.rows.length === 0) {
      return res.json({ status: 0, message: 'Application not found' });
    }

    res.json({ status: 1, message: 'Status updated successfully', application: result.rows[0] });
  } catch (error) {
    console.error('Update status error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// ===================== CATEGORIES ENDPOINTS =====================

// Get Categories
app.get('/api/categories.php', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM categories ORDER BY name');
    res.json(result.rows);
  } catch (error) {
    console.error('Get categories error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// ===================== NEWS ENDPOINTS =====================

// Get News
app.get('/api/news.php', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM news ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (error) {
    console.error('Get news error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// ===================== COMPANIES ENDPOINTS =====================

// Get Companies
app.get('/api/companies.php', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT DISTINCT company_name FROM jobs WHERE status = $1 ORDER BY company_name',
      ['active']
    );
    res.json(result.rows.map(row => ({ name: row.company_name })));
  } catch (error) {
    console.error('Get companies error:', error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// ===================== DOWNLOAD RESUME ENDPOINT =====================

// Placeholder for resume download
app.get('/api/download_resume.php', (req, res) => {
  res.json({ status: 0, message: 'Resume download not implemented' });
});

// ===================== STATIC FILE SERVING =====================

// Serve React app on all other routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

// Error Handling
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ status: 0, message: 'Server error' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════╗
║       HireWay Server Started          ║
╠════════════════════════════════════════╣
║ Port: ${PORT}                              ║
║ Environment: ${process.env.NODE_ENV || 'development'}        ║
║ Database: PostgreSQL (Supabase)       ║
║ API: http://localhost:${PORT}/api/health  ║
╚════════════════════════════════════════╝
  `);
});

// Graceful shutdown
process.on('SIGINT', () => {
  console.log('Shutting down gracefully...');
  pool.end();
  process.exit(0);
});
