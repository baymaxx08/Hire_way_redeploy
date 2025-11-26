# HireWay Deployment Guide

## Frontend Deployment to Vercel

### Steps to Deploy:

1. **Connect Repository to Vercel**
   - Go to https://vercel.com/new
   - Import the GitHub repository
   - Select "HireWay" as the project

2. **Environment Variables**
   Set these in Vercel Dashboard under Settings > Environment Variables:
   ```
   REACT_APP_API_BASE_URL=https://your-backend-api-domain.com/api
   ```

3. **Build Command**
   ```
   npm run build
   ```

4. **Output Directory**
   ```
   build
   ```

## Backend Deployment Options

### Option 1: Use a Node.js Backend (Recommended)
Convert PHP to Node.js using Express.js and deploy to:
- Heroku (free tier available)
- Railway.app
- Render.com

### Option 2: Keep PHP Backend
Deploy to:
- InfinityFree (free hosting with PHP)
- 000webhost
- Altervista

### Option 3: Use Serverless Functions
Deploy PHP code to:
- Firebase Functions
- AWS Lambda
- Vercel Serverless Functions

## Database Options

### Option 1: Firebase Firestore (Recommended)
- Free tier: 1GB storage, 50K reads/writes daily
- Real-time database
- Easy integration with React

### Option 2: MongoDB Atlas
- Free tier: 512MB storage
- Easy to use
- Good for Node.js backend

### Option 3: Supabase (PostgreSQL)
- Free tier: 500MB storage, unlimited API calls
- PostgreSQL with real-time capabilities

## Current Configuration
All API endpoints are now centralized in `src/config/apiConfig.js`
Environment variables are used in `.env` file
Simply update `REACT_APP_API_BASE_URL` for deployment

## Testing Before Deployment
1. Update `.env` with production API URL
2. Run `npm run build`
3. Test build locally: `npm serve -s build` (after installing serve)
