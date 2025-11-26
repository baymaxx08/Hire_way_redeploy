-- HireWay Database Schema
-- Run these SQL commands to set up your database

CREATE DATABASE IF NOT EXISTS hireway;
USE hireway;

-- Users table
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('job_seeker', 'job_poster') DEFAULT 'job_seeker',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_role (role)
);

-- Jobs table
CREATE TABLE IF NOT EXISTS jobs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  salary VARCHAR(100),
  job_type VARCHAR(50),
  description LONGTEXT,
  requirements LONGTEXT,
  poster_email VARCHAR(255) NOT NULL,
  status ENUM('active', 'closed') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (poster_email) REFERENCES users(email) ON DELETE CASCADE,
  INDEX idx_poster_email (poster_email),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
);

-- Applications table
CREATE TABLE IF NOT EXISTS applications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  user_email VARCHAR(255) NOT NULL,
  job_title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  poster_email VARCHAR(255) NOT NULL,
  job_id INT,
  resume_path VARCHAR(500),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_email) REFERENCES users(email) ON DELETE CASCADE,
  FOREIGN KEY (poster_email) REFERENCES users(email) ON DELETE CASCADE,
  FOREIGN KEY (job_id) REFERENCES jobs(id) ON DELETE CASCADE,
  INDEX idx_user_email (user_email),
  INDEX idx_poster_email (poster_email),
  INDEX idx_status (status),
  INDEX idx_created_at (created_at)
);

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_name (name)
);

-- News table
CREATE TABLE IF NOT EXISTS news (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content LONGTEXT NOT NULL,
  image_url VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_created_at (created_at)
);

-- Insert sample categories
INSERT INTO categories (name, description) VALUES 
  ('Technology', 'Tech and Software Development jobs'),
  ('Finance', 'Financial services and banking jobs'),
  ('Healthcare', 'Medical and healthcare jobs'),
  ('Marketing', 'Marketing and sales jobs'),
  ('Design', 'Design and creative jobs'),
  ('Operations', 'Operations and management jobs')
ON DUPLICATE KEY UPDATE id=id;

-- Insert sample news
INSERT INTO news (title, content, image_url) VALUES 
  ('Tech Industry Boom', 'The technology sector continues to grow with record job openings...', 'https://via.placeholder.com/300x200?text=Tech'),
  ('Job Market Update', 'Latest trends in the job market for 2024...', 'https://via.placeholder.com/300x200?text=Jobs'),
  ('Career Development', 'Tips for advancing your career in 2024...', 'https://via.placeholder.com/300x200?text=Career')
ON DUPLICATE KEY UPDATE id=id;

-- Create stored procedures for common operations

DELIMITER $$

-- Procedure to get user statistics
CREATE PROCEDURE IF NOT EXISTS get_user_stats()
BEGIN
  SELECT 
    COUNT(*) as total_users,
    SUM(CASE WHEN role = 'job_seeker' THEN 1 ELSE 0 END) as job_seekers,
    SUM(CASE WHEN role = 'job_poster' THEN 1 ELSE 0 END) as job_posters
  FROM users;
END $$

-- Procedure to get job statistics
CREATE PROCEDURE IF NOT EXISTS get_job_stats()
BEGIN
  SELECT 
    COUNT(*) as total_jobs,
    SUM(CASE WHEN status = 'active' THEN 1 ELSE 0 END) as active_jobs,
    SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) as closed_jobs
  FROM jobs;
END $$

-- Procedure to get application statistics
CREATE PROCEDURE IF NOT EXISTS get_application_stats()
BEGIN
  SELECT 
    COUNT(*) as total_applications,
    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending,
    SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END) as approved,
    SUM(CASE WHEN status = 'rejected' THEN 1 ELSE 0 END) as rejected
  FROM applications;
END $$

DELIMITER ;

-- Display schema creation confirmation
SELECT '✓ Database schema created successfully!' as status;
