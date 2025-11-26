# 🚀 HireWay - Single Site Render Deployment (5-Minute Start)

## What You're Deploying

✅ **One Single URL** with both Frontend + Backend
✅ **All features included** - Jobs, Applications, User Accounts
✅ **Free hosting** on Render.com
✅ **Database** on Supabase (free 500MB)
✅ **Total cost** $0/month

---

## Quick Start (5 Steps)

### Step 1: Create Supabase Account (2 min)
```
1. Go to supabase.com
2. Sign up with GitHub
3. Create project "hireway"
4. Save these credentials:
   - DB_HOST
   - DB_USER (postgres)
   - DB_PASSWORD
   - DB_NAME
```

### Step 2: Import Database (1 min)
```
In Supabase Dashboard:
1. SQL Editor
2. Paste: database-schema.sql content
3. Execute
Done!
```

### Step 3: Push to GitHub (1 min)
```bash
git add .
git commit -m "Ready for Render deployment"
git push origin master
```

### Step 4: Deploy to Render (1 min)
```
1. Go to render.com
2. Sign in with GitHub
3. New Web Service
4. Select HireWay repo
5. Fill in settings:
   - Build: npm run build
   - Start: npm start
   - Add DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
6. Deploy
```

### Step 5: Test (Automatic)
```
Wait 2-3 minutes...
Your app is live at: https://hireway.onrender.com
```

---

## That's It! 🎉

Your application is now running on:

```
🌐 Frontend:  https://hireway.onrender.com
🔌 API:       https://hireway.onrender.com/api
✅ Status:    https://hireway.onrender.com/api/health
```

---

## Share Your App

**Send this URL to users:**
```
https://hireway.onrender.com
```

Users can immediately:
- ✅ Register and login
- ✅ Browse jobs
- ✅ Post jobs
- ✅ Apply for jobs
- ✅ Track applications

---

## Make Updates

### To update your application:

```bash
# Make changes locally
npm run build  # Test it works

# Push to GitHub (Render auto-deploys)
git add .
git commit -m "New feature: description"
git push origin master

# Done! Check https://render.com for status
```

---

## Troubleshooting

### ❌ Build fails
→ Check Render logs for error message

### ❌ API not working
→ Verify DB credentials in environment variables

### ❌ Can't connect to database
→ Ensure Supabase project is active

### ❌ Frontend shows but API fails
→ Check browser console for errors

---

## All Set! 

Your single-site deployment on Render is:
- ✅ Live and running
- ✅ Accessible worldwide
- ✅ Automatically updating
- ✅ Free to use
- ✅ Production-ready

**Next:** Share your URL and get feedback! 🎊

---

**Full Guide:** See `RENDER_DEPLOYMENT.md`
