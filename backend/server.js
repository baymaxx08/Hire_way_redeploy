require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Database Connection Pool
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'hireway',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Health Check
app.get('/api/health', (req, res) => {
  res.json({ status: 'API is running' });
});

// Login Endpoint
app.post('/api/login.php', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.json({ status: 0, message: 'Invalid input data' });
    }

    const connection = await pool.getConnection();
    const [users] = await connection.query('SELECT id, name, email, password, role FROM users WHERE email = ?', [email]);
    connection.release();

    if (users.length === 0) {
      return res.json({ status: 0, message: 'Invalid email or password' });
    }

    const user = users[0];
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
    console.error(error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Register Endpoint
app.post('/api/users.php', async (req, res) => {
  try {
    const { name, email, password, role } = req.body;

    if (!name || !email || !password || !role) {
      return res.json({ status: 0, message: 'Invalid input data' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const connection = await pool.getConnection();

    const [result] = await connection.query(
      'INSERT INTO users (name, email, password, role, created_at) VALUES (?, ?, ?, ?, NOW())',
      [name, email, hashedPassword, role]
    );

    connection.release();

    res.json({ status: 1, message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    if (error.message.includes('ER_DUP_ENTRY')) {
      res.json({ status: 0, message: 'Email already exists' });
    } else {
      res.json({ status: 0, message: 'Error: ' + error.message });
    }
  }
});

// Get Jobs
app.get('/api/jobs.php', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const [jobs] = await connection.query('SELECT * FROM jobs ORDER BY created_at DESC');
    connection.release();

    res.json(jobs);
  } catch (error) {
    console.error(error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Post Job
app.post('/api/post_job.php', async (req, res) => {
  try {
    const { jobTitle, companyName, location, salary, jobType, description, requirements, poster_email } = req.body;

    const connection = await pool.getConnection();
    await connection.query(
      'INSERT INTO jobs (title, company_name, location, salary, job_type, description, requirements, poster_email, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())',
      [jobTitle, companyName, location, salary, jobType, description, requirements, poster_email]
    );
    connection.release();

    res.json({ status: 1, message: 'Job posted successfully' });
  } catch (error) {
    console.error(error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Apply for Job
app.post('/api/apply_job.php', async (req, res) => {
  try {
    const { userName, email, employer_email, jobTitle, companyName, resume } = req.body;

    const connection = await pool.getConnection();
    await connection.query(
      'INSERT INTO applications (user_name, user_email, job_title, company_name, poster_email, status, created_at) VALUES (?, ?, ?, ?, ?, ?, NOW())',
      [userName, email, jobTitle, companyName, employer_email, 'pending']
    );
    connection.release();

    res.json({ status: 1, message: 'Application submitted successfully' });
  } catch (error) {
    console.error(error);
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

    const connection = await pool.getConnection();
    const [applications] = await connection.query(
      'SELECT * FROM applications WHERE user_email = ? ORDER BY created_at DESC',
      [user_email]
    );
    connection.release();

    res.json({ status: 1, applications });
  } catch (error) {
    console.error(error);
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

    const connection = await pool.getConnection();
    const [applications] = await connection.query(
      'SELECT * FROM applications WHERE poster_email = ? ORDER BY created_at DESC',
      [poster_email]
    );
    connection.release();

    res.json({ status: 1, applications });
  } catch (error) {
    console.error(error);
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

    const connection = await pool.getConnection();
    await connection.query('UPDATE applications SET status = ? WHERE id = ?', [status, id]);
    connection.release();

    res.json({ status: 1, message: 'Status updated successfully' });
  } catch (error) {
    console.error(error);
    res.json({ status: 0, message: 'Error: ' + error.message });
  }
});

// Error Handling
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ status: 0, message: 'Server error' });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`HireWay Backend API running on port ${PORT}`);
});
