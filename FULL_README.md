# HireWay - Complete Job Portal Application

A full-stack job portal application with React frontend and Node.js/Express backend.

## Project Structure

```
HireWay/
├── src/                    # React frontend source code
├── backend/                # Node.js/Express backend
├── public/                 # Static assets
├── package.json            # Frontend dependencies
├── vercel.json             # Vercel deployment config
├── .env                    # Environment variables (frontend)
├── DEPLOYMENT_GUIDE.md     # Detailed deployment instructions
└── README.md               # This file
```

## Quick Start - Local Development

### Frontend Setup

```bash
# Install dependencies
npm install

# Create .env file
echo "REACT_APP_API_BASE_URL=http://localhost:5000/api" > .env

# Start development server
npm start
```

The app will open at `http://localhost:3000`

### Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Create .env file
cp .env.example .env

# Configure your database in .env
# DB_HOST=localhost
# DB_USER=root
# DB_PASSWORD=your_password
# DB_NAME=hireway

# Start backend server
npm start
```

The API will run at `http://localhost:5000/api`

## Database Setup

### Create MySQL Database

```sql
CREATE DATABASE hireway;

USE hireway;

-- Users table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('job_seeker', 'job_poster') DEFAULT 'job_seeker',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Jobs table
CREATE TABLE jobs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  salary VARCHAR(100),
  job_type VARCHAR(50),
  description TEXT,
  requirements TEXT,
  poster_email VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (poster_email) REFERENCES users(email)
);

-- Applications table
CREATE TABLE applications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  user_email VARCHAR(255) NOT NULL,
  job_title VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) NOT NULL,
  poster_email VARCHAR(255) NOT NULL,
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_email) REFERENCES users(email),
  FOREIGN KEY (poster_email) REFERENCES users(email)
);
```

## Features

### For Job Seekers
- ✅ Browse all job listings
- ✅ Apply for jobs with resume upload
- ✅ Track application status
- ✅ User authentication and registration

### For Job Posters
- ✅ Post job listings
- ✅ Manage job applications
- ✅ Download candidate resumes
- ✅ Update application status (Approve/Reject)

## API Endpoints

### Authentication
- `POST /api/login.php` - User login
- `POST /api/users.php` - User registration

### Jobs
- `GET /api/jobs.php` - Get all jobs
- `POST /api/post_job.php` - Post new job
- `POST /api/apply_job.php` - Apply for a job

### Applications
- `GET /api/applications.php?user_email=<email>` - Get user's applications
- `GET /api/get_applications.php?poster_email=<email>` - Get applications for posted jobs
- `POST /api/update_application_status.php` - Update application status

## Deployment

### Frontend (Vercel)

1. Connect repository to Vercel
2. Set environment variable: `REACT_APP_API_BASE_URL=<production-api-url>`
3. Deploy!

### Backend (Railway/Render/Heroku)

1. Set environment variables:
   - `DB_HOST` - Database host
   - `DB_USER` - Database user
   - `DB_PASSWORD` - Database password
   - `DB_NAME` - Database name
   - `PORT` - Server port

2. Deploy using platform's CLI or Git integration

See `DEPLOYMENT_GUIDE.md` for detailed instructions.

## Environment Variables

### Frontend (.env)
```
REACT_APP_API_BASE_URL=http://localhost:5000/api
```

### Backend (backend/.env)
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=hireway
PORT=5000
NODE_ENV=development
```

## Technologies Used

### Frontend
- React.js 18
- React Router v6
- Axios
- CSS3

### Backend
- Node.js
- Express.js
- MySQL2
- bcryptjs
- CORS

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)

## License

This project is open source and available under the MIT License.

## Support

For issues and questions, please open an issue in the repository.
