# Cloud Database Setup Guide

## Option 1: Supabase (PostgreSQL) - RECOMMENDED

### Why Supabase?
- Free tier: 500MB storage
- PostgreSQL database with real-time capabilities
- Built-in authentication APIs
- Easy integration with Node.js
- Generous free tier

### Setup Steps:

1. **Create Supabase Account**
   - Go to https://supabase.com
   - Sign up with GitHub
   - Create new project

2. **Get Connection String**
   - In Supabase dashboard, go to Settings > Database
   - Copy the Connection String for Node.js
   - Format: `postgresql://user:password@host:5432/dbname`

3. **Update Backend Configuration**
   ```
   DB_HOST=your-project.supabase.co
   DB_USER=postgres
   DB_PASSWORD=your-password
   DB_NAME=postgres
   ```

4. **Create Tables**
   - Use SQL Editor in Supabase dashboard
   - Run the SQL commands from `database-schema.sql`

5. **Update Backend Code**
   - Backend is already configured to use environment variables
   - Just set the DB_* variables

---

## Option 2: MongoDB Atlas (Cloud)

### Why MongoDB?
- Free tier: 512MB storage
- NoSQL - easier to scale
- Generous free tier
- Works well with Node.js/Express

### Setup Steps:

1. **Create MongoDB Atlas Account**
   - Go to https://www.mongodb.com/cloud/atlas
   - Sign up with email
   - Create new cluster (Free tier)

2. **Create Database User**
   - Go to Database Access
   - Create new user
   - Save username and password

3. **Get Connection String**
   - Go to Databases
   - Click "Connect"
   - Copy Connection String
   - Format: `mongodb+srv://user:password@cluster.mongodb.net/dbname`

4. **Update Backend Configuration**
   - Create `.env` file in backend folder:
   ```
   MONGODB_URI=mongodb+srv://user:password@cluster.mongodb.net/hireway
   NODE_ENV=production
   PORT=5000
   ```

5. **Update Backend for MongoDB**
   - Install Mongoose: `npm install mongoose`
   - Use Mongoose models instead of SQL queries

---

## Option 3: Firebase Firestore

### Why Firebase?
- Free tier: 1GB storage, 50K reads/writes daily
- Real-time database
- Built-in authentication
- Easy to use

### Setup Steps:

1. **Create Firebase Project**
   - Go to https://firebase.google.com
   - Click "Get Started"
   - Create new project

2. **Enable Firestore**
   - In Firebase Console, go to Build > Firestore Database
   - Create database in test mode
   - Select location

3. **Get Credentials**
   - Go to Settings > Service Accounts
   - Generate new private key
   - Save as `firebase-key.json`

4. **Update Backend**
   - Install Firebase Admin: `npm install firebase-admin`
   - Use Firebase SDK instead of SQL queries

---

## Recommended Setup (Easiest)

### Frontend
1. Create `.env` file:
   ```
   REACT_APP_API_BASE_URL=https://your-backend-url.com/api
   ```

2. Deploy to Vercel:
   ```bash
   npm i -g vercel
   vercel
   ```

### Backend
1. Set up Supabase database
2. Create `.env` in backend folder with Supabase credentials
3. Deploy to Railway/Render:
   - Connect GitHub repository
   - Set environment variables
   - Deploy!

### Example Deployment URLs:
- **Frontend:** https://hireway.vercel.app
- **Backend:** https://hireway-backend.railway.app

---

## Environment Variables Checklist

### Vercel (Frontend)
- [ ] `REACT_APP_API_BASE_URL` - Your backend API URL

### Railway/Render/Heroku (Backend)
- [ ] `DB_HOST` - Database host
- [ ] `DB_USER` - Database user
- [ ] `DB_PASSWORD` - Database password
- [ ] `DB_NAME` - Database name
- [ ] `PORT` - Server port (3000-5000)
- [ ] `NODE_ENV` - Set to `production`

---

## Testing Cloud Setup

1. **Local Testing**
   ```bash
   npm install
   npm run build
   npm install -g serve
   serve -s build
   ```

2. **Check API Connectivity**
   - Open browser console
   - Go to Network tab
   - Register or login
   - Check if API calls succeed

3. **Debug Issues**
   - Check CORS headers
   - Verify environment variables
   - Check backend logs

---

## Troubleshooting

### Issue: CORS Error
**Solution:** 
- Check backend CORS configuration
- Verify frontend URL is whitelisted
- Ensure API_BASE_URL doesn't have trailing slash

### Issue: Database Connection Failed
**Solution:**
- Verify database credentials
- Check IP whitelist in database settings
- Ensure database server is running

### Issue: API Returns 404
**Solution:**
- Check API endpoint paths
- Verify backend is running
- Check request headers

### Issue: File Upload Not Working
**Solution:**
- Ensure multer is configured
- Check file size limits
- Verify upload directory exists

---

## Next Steps

1. Choose your cloud provider
2. Set up database
3. Update environment variables
4. Deploy backend
5. Deploy frontend
6. Update frontend API URL
7. Test the complete application

For more help, see the main README.md file.
