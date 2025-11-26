// API Configuration
// Use environment variable for custom API URL, otherwise use relative paths for same-origin requests
const API_BASE_URL = process.env.REACT_APP_API_BASE_URL || '/api';

export const API_ENDPOINTS = {
  LOGIN: `${API_BASE_URL}/login.php`,
  REGISTER: `${API_BASE_URL}/users.php`,
  JOBS: `${API_BASE_URL}/jobs.php`,
  APPLY_JOB: `${API_BASE_URL}/apply_job.php`,
  APPLICATIONS: `${API_BASE_URL}/applications.php`,
  POST_JOB: `${API_BASE_URL}/post_job.php`,
  GET_APPLICATIONS: `${API_BASE_URL}/get_applications.php`,
  UPDATE_APPLICATION_STATUS: `${API_BASE_URL}/update_application_status.php`,
  DOWNLOAD_RESUME: `${API_BASE_URL}/download_resume.php`,
  CATEGORIES: `${API_BASE_URL}/categories.php`,
  COMPANIES: `${API_BASE_URL}/companies.php`,
  NEWS: `${API_BASE_URL}/news.php`,
};

export default API_ENDPOINTS;
