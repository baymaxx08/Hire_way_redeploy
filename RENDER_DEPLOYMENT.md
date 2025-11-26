# 🚀 HireWay - Render.com Single Site Deployment Guide

## Overview

Deploy the entire HireWay application (Frontend + Backend + Database) as a **single unified service on Render.com**.

**Total Time:** 20 minutes
**Total Cost:** $0/month (free tier)
**URL Example:** `https://hireway.onrender.com`

---

## 📋 Prerequisites

- GitHub account with repo access
- Render.com account (free)
- Database credentials (MySQL/Supabase)
- 10 minutes of your time

---

## 🛠️ Setup Steps

### Step 1: Create Supabase Database (5 minutes)

1. **Go to** https://supabase.com
2. **Sign up** with GitHub
3. **Create new project**
   - Name: `hireway`
   - Password: Create strong password
4. **Run SQL Schema:**
   - Go to SQL Editor
   - Copy all SQL from `database-schema.sql`
   - Execute
5. **Get Connection Details:**
   - Settings > Database
   - Copy credentials:
     ```
     DB_HOST: [your-project].supabase.co
     DB_USER: postgres
     DB_PASSWORD: [your-password]
     DB_NAME: postgres
     ```

### Step 2: Prepare Project (Already Done ✅)

The project is already configured for Render:
- ✅ `server.js` - Unified Node.js server
- ✅ `render.yaml` - Deployment configuration
- ✅ `package.json` - All dependencies included
- ✅ API endpoints ready
- ✅ Static file serving configured

### Step 3: Deploy to Render (10 minutes)

#### 3.1 Connect Repository

1. **Go to** https://render.com
2. **Sign in** with GitHub
3. **Click** "New +" > "Web Service"
4. **Select** your HireWay repository
5. **Click** "Connect"

#### 3.2 Configure Service

1. **Name:** `hireway`
2. **Environment:** Node
3. **Region:** Closest to you
4. **Branch:** `master`
5. **Build Command:**
   ```
   npm run build
   ```
6. **Start Command:**
   ```
   npm start
   ```
7. **Plan:** Free

#### 3.3 Set Environment Variables

Click "Add Environment Variable" for each:

```
DB_HOST = [your-supabase-host]
DB_USER = postgres
DB_PASSWORD = [your-password]
DB_NAME = postgres
NODE_ENV = production
PORT = 3000
```

#### 3.4 Deploy

1. **Click** "Create Web Service"
2. **Wait** for deployment (2-3 minutes)
3. **View Logs** to confirm success

---

## ✅ Deployment Verification

Once deployed, test these URLs:

```
Frontend:  https://hireway.onrender.com
API:       https://hireway.onrender.com/api/health
Jobs:      https://hireway.onrender.com/api/jobs.php
```

### Test API Health
```bash
curl https://hireway.onrender.com/api/health
```

Expected response:
```json
{"status":"API is running"}
```

---

## 🎯 Usage

### Production URL
- **Frontend:** `https://hireway.onrender.com`
- **API Base:** `https://hireway.onrender.com/api`

### Features Working
- ✅ User registration/login
- ✅ Job posting
- ✅ Job browsing
- ✅ Job applications
- ✅ Application tracking
- ✅ All features from original

---

## 🔄 Updating Your App

### To update the deployed application:

1. **Make changes** locally
2. **Test locally:**
   ```bash
   npm run build
   npm start
   ```
3. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Update: description"
   git push origin master
   ```
4. **Render auto-deploys** (2-3 minutes)

### Monitor Deployment
- Go to Render dashboard
- Click your service
- View real-time logs
- See deployment status

---

## 🐛 Troubleshooting

### Issue: Build fails

**Solution:**
1. Check Render logs for error
2. Ensure all dependencies installed locally
3. Run `npm install` and commit
4. Push changes and redeploy

### Issue: API not working

**Solution:**
1. Verify environment variables are set
2. Check database credentials
3. Ensure database is accessible
4. Test with curl: `curl https://hireway.onrender.com/api/health`

### Issue: Database connection fails

**Solution:**
1. Verify all DB credentials are correct
2. Check Supabase project is active
3. Ensure IP whitelist allows connections
4. Test connection from local machine first

### Issue: Frontend loads but API calls fail

**Solution:**
1. Check browser console for errors
2. Verify CORS is enabled (it is by default)
3. Check network tab in DevTools
4. Ensure `/api` endpoints are correct

### Issue: Slow performance

**Solution:**
- Free tier has limited resources
- Upgrade to paid plan for better performance
- Render automatically scales as needed

---

## 📊 Free Tier Limits

Render.com free tier includes:

- **RAM:** 0.5 GB
- **CPU:** Shared
- **Bandwidth:** Unlimited
- **Concurrent connections:** 100
- **Auto-sleep:** After 15 min of inactivity
- **Wake-up:** Automatic on request

### Upgrade When:
- App needs always-on availability
- High traffic expected
- Premium support needed
- More resources required

---

## 🔐 Security Notes

1. **Environment Variables:** Stored securely in Render
2. **Database:** Protected with strong passwords
3. **HTTPS:** Automatic SSL certificate
4. **API:** Uses HTTP-only same-origin requests
5. **Backups:** Set up Supabase backups

---

## 📱 Access Your Application

### Web URL
```
https://hireway.onrender.com
```

### API Endpoints
```
POST   /api/login.php
POST   /api/users.php
GET    /api/jobs.php
POST   /api/post_job.php
GET    /api/applications.php
POST   /api/apply_job.php
```

### Share With Users
```
https://hireway.onrender.com
```

---

## 🚀 Next Steps

### Immediate
- [ ] Database set up
- [ ] Deploy to Render
- [ ] Test all features

### This Week
- [ ] Share URL with team
- [ ] Collect user feedback
- [ ] Monitor logs

### This Month
- [ ] Add more features
- [ ] Scale database
- [ ] Upgrade plan if needed

---

## 💡 Pro Tips

1. **Custom Domain**
   - Render supports custom domains
   - Add in service settings
   - Enable auto-renewal for SSL

2. **Monitor Performance**
   - Check Render metrics
   - View analytics
   - Optimize as needed

3. **Auto-Deploy**
   - Render auto-deploys on git push
   - No manual deployment needed
   - Check logs for status

4. **Scaling**
   - Upgrade to paid plan
   - Render handles auto-scaling
   - Choose plan based on needs

---

## 📞 Support

### Render Support
- https://render.com/docs
- https://render.com/support

### Supabase Support
- https://supabase.com/docs
- https://supabase.com/support

### Project Issues
- Check logs in Render dashboard
- Verify environment variables
- Test endpoints with curl/Postman

---

## ✨ What You Get

```
Single Unified Deployment:
✅ Frontend + Backend on one URL
✅ Single deployment process
✅ No complex configuration
✅ Automatic SSL/HTTPS
✅ Free tier hosting
✅ Auto-scaling available
✅ Easy to update
✅ Production-ready
```

---

## 🎉 Success Checklist

- [ ] Supabase database created
- [ ] Database schema imported
- [ ] Environment variables saved
- [ ] Repository connected to Render
- [ ] Service deployed successfully
- [ ] Frontend loads
- [ ] API responds
- [ ] Database connected
- [ ] All features working
- [ ] URL shared with team

---

## 📝 Quick Reference

### URLs
- Frontend: `https://hireway.onrender.com`
- API: `https://hireway.onrender.com/api`
- Health Check: `https://hireway.onrender.com/api/health`

### Environment Variables
```
DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
NODE_ENV=production, PORT=3000
```

### Commands
```
Build: npm run build
Start: npm start
Dev: npm run dev
```

---

**Status:** ✅ Ready for Render Deployment
**Total Setup Time:** 20 minutes
**Monthly Cost:** $0 (free tier)
**Next Step:** Follow steps above

Good luck with your deployment! 🚀
