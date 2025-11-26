-- HireWay Database Schema for PostgreSQL (Supabase)
-- Run these SQL commands to set up your database

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'job_seeker' CHECK (role IN ('job_seeker', 'job_poster')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- Jobs table
CREATE TABLE IF NOT EXISTS jobs (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  salary VARCHAR(100),
  job_type VARCHAR(50),
  description TEXT,
  requirements TEXT,
  poster_email VARCHAR(255) NOT NULL,
  status VARCHAR(50) DEFAULT 'active' CHECK (status IN ('active', 'closed')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poster_email) REFERENCES users(email) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_jobs_poster_email ON jobs(poster_email);
CREATE INDEX IF NOT EXISTS idx_jobs_status ON jobs(status);
CREATE INDEX IF NOT EXISTS idx_jobs_created_at ON jobs(created_at);

-- Applications table
CREATE TABLE IF NOT EXISTS applications (
  id SERIAL PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  user_email VARCHAR(255) NOT NULL,
  job_title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  poster_email VARCHAR(255) NOT NULL,
  job_id INT,
  resume_path VARCHAR(500),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_email) REFERENCES users(email) ON DELETE CASCADE,
  FOREIGN KEY (poster_email) REFERENCES users(email) ON DELETE CASCADE,
  FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_applications_user_email ON applications(user_email);
CREATE INDEX IF NOT EXISTS idx_applications_poster_email ON applications(poster_email);
CREATE INDEX IF NOT EXISTS idx_applications_status ON applications(status);
CREATE INDEX IF NOT EXISTS idx_applications_created_at ON applications(created_at);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_categories_name ON categories(name);

-- News table
CREATE TABLE IF NOT EXISTS news (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  image_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_news_created_at ON news(created_at);

-- Insert sample categories (using PostgreSQL INSERT syntax)
INSERT INTO categories (name, description) VALUES 
  ('Technology', 'Tech and Software Development jobs'),
  ('Finance', 'Financial services and banking jobs'),
  ('Healthcare', 'Medical and healthcare jobs'),
  ('Marketing', 'Marketing and sales jobs'),
  ('Design', 'Design and creative jobs'),
  ('Operations', 'Operations and management jobs')
ON CONFLICT (name) DO NOTHING;

-- Insert sample news
INSERT INTO news (title, content, image_url) VALUES 
  ('Tech Industry Boom', 'The technology sector continues to grow with record job openings...', 'https://via.placeholder.com/300x200?text=Tech'),
  ('Job Market Update', 'Latest trends in the job market for 2024...', 'https://via.placeholder.com/300x200?text=Jobs'),
  ('Career Development', 'Tips for advancing your career in 2024...', 'https://via.placeholder.com/300x200?text=Career')
ON CONFLICT DO NOTHING;

-- Create functions for common operations

-- Function to get user statistics
CREATE OR REPLACE FUNCTION get_user_stats()
RETURNS TABLE (total_users BIGINT, job_seekers BIGINT, job_posters BIGINT) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*),
    SUM(CASE WHEN role = 'job_seeker' THEN 1 ELSE 0 END),
    SUM(CASE WHEN role = 'job_poster' THEN 1 ELSE 0 END)
  FROM users;
END;
$$ LANGUAGE plpgsql;

-- Function to get job statistics
CREATE OR REPLACE FUNCTION get_job_stats()
RETURNS TABLE (total_jobs BIGINT, active_jobs BIGINT, closed_jobs BIGINT) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*),
    SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END),
    SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END)
  FROM jobs;
END;
$$ LANGUAGE plpgsql;

-- Function to get application statistics
CREATE OR REPLACE FUNCTION get_application_stats()
RETURNS TABLE (total_applications BIGINT, pending BIGINT, approved BIGINT, rejected BIGINT) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    COUNT(*),
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END),
    SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END),
    SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END)
  FROM applications;
END;
$$ LANGUAGE plpgsql;

-- Confirm schema creation
SELECT 'Database schema created successfully for PostgreSQL!' as status;
