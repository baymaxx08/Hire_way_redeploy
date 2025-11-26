# QUICK START DEPLOYMENT GUIDE

## 🚀 RECOMMENDED: Single Site on Render (5 minutes, $0/month)

👉 **Read:** `RENDER_QUICK_START.md` (fastest way to deploy!)

Deploy everything on one URL: `https://hireway.onrender.com`

---

### Option A: Deploy to Vercel (Easiest)

**Step 1: Prepare Frontend**
```bash
# In project root
npm install
npm run build
```

**Step 2: Deploy Frontend**
```bash
npm i -g vercel
vercel
# Follow the prompts
```

**Step 3: Set Backend URL**
- After deployment, go to Vercel Dashboard
- Project Settings > Environment Variables
- Add: `REACT_APP_API_BASE_URL=https://your-backend-url.com/api`
- Redeploy

---

### Option B: Deploy Everything Free (Recommended)

#### Frontend on Vercel
1. Go to https://vercel.com/new
2. Connect GitHub repository
3. Click "Deploy"

#### Backend on Railway.app
1. Go to https://railway.app
2. New Project > GitHub Repo
3. Set environment variables:
   - `DB_HOST` - Your database host
   - `DB_USER` - Database user
   - `DB_PASSWORD` - Database password
   - `DB_NAME` - Database name
4. Deploy!

#### Database on Supabase
1. Go to https://supabase.com
2. Create new project
3. Run SQL from `database-schema.sql`
4. Get connection details
5. Use credentials for Railway backend

---

## 📋 Pre-Deployment Checklist

- [ ] Frontend builds successfully: `npm run build`
- [ ] Backend dependencies installed: `cd backend && npm install`
- [ ] Database is set up locally
- [ ] `.env` files configured
- [ ] All API endpoints use centralized config
- [ ] Tests pass (if any)

---

## 🔧 Fix Any Build Errors

### If you see CORS error:
1. Update `.env` with correct API URL
2. Ensure backend CORS is configured for frontend domain

### If you see API 404 error:
1. Check backend is running
2. Verify API_ENDPOINTS match backend routes

### If you see database connection error:
1. Verify database credentials in `.env`
2. Check database server is running
3. Ensure firewall allows connections

---

## 📚 Full Documentation

- `README.md` - Project overview
- `FULL_README.md` - Complete setup guide
- `DEPLOYMENT_GUIDE.md` - Detailed deployment instructions
- `CLOUD_SETUP.md` - Cloud database setup
- `database-schema.sql` - Database schema

---

## 🎯 Next Steps After Deployment

1. Test user registration
2. Test job posting
3. Test job application
4. Test application status tracking
5. Monitor backend logs

---

## ⚠️ Important Notes

- All API URLs are configured in `src/config/apiConfig.js`
- Environment variables in `.env` are not uploaded to GitHub
- Update `.env` for each deployment (local, staging, production)
- Keep sensitive data in environment variables, never in code

---

## 💡 Troubleshooting

**Problem:** Build fails
- Solution: `rm -rf node_modules && npm install && npm run build`

**Problem:** API calls fail
- Solution: Check REACT_APP_API_BASE_URL in Vercel environment variables

**Problem:** Database connection fails
- Solution: Verify credentials and IP whitelist in database settings

**Problem:** CORS errors
- Solution: Ensure backend has CORS enabled for frontend domain

---

## 🎓 Learning Resources

- React Documentation: https://react.dev
- Express.js Guide: https://expressjs.com
- MySQL Guide: https://dev.mysql.com
- Node.js Documentation: https://nodejs.org

---

## 📞 Getting Help

If something isn't working:
1. Check the error message in browser console
2. Check backend logs (if deployed)
3. Verify environment variables
4. Test API endpoints with Postman/cURL
5. Review the full documentation files

---

**Good luck with your deployment! 🚀**
