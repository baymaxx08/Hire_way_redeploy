# 🔍 RENDER DEPLOYMENT - COMPLETE TROUBLESHOOTING GUIDE

## ❌ **YOUR CURRENT STATUS**

Error: `connect ENETUNREACH` on registration
This means: **Render cannot reach Supabase database**

---

## ✅ **VERIFICATION CHECKLIST**

### **STEP 1: Verify Supabase is Set Up** (Take Screenshot!)
```
Go to: https://supabase.com
1. ✅ You have created a project? YES/NO
2. ✅ You ran database-schema.sql? YES/NO  
3. ✅ Can you see the "users" table? YES/NO
```

Get your Supabase Connection String:
- Go to Settings → Database
- Look for Connection String section
- Copy the values:
  - **Host:** xxxxx.supabase.co (this is DB_HOST)
  - **Port:** 5432
  - **User:** postgres (this is DB_USER)
  - **Password:** (what you set) (this is DB_PASSWORD)
  - **Database:** postgres (this is DB_NAME)

---

### **STEP 2: Set Environment Variables on Render** (CRITICAL!)
```
1. Go to: https://render.com/dashboard
2. Click on "hireway" service
3. Click "Settings" (bottom of page)
4. Scroll to "Environment" section
5. Click "Add Environment Variable"
6. Add EXACTLY these 4 variables:

   DB_HOST = your-xxx.supabase.co
   DB_USER = postgres
   DB_PASSWORD = your-password-here
   DB_NAME = postgres
   NODE_ENV = production

7. IMPORTANT: Make sure they're in the "Run environment" section
   (NOT "Build environment")
8. Click "Save" (you may need to redeploy)
```

---

### **STEP 3: Verify Environment Variables Were Saved**
```
1. Stay on Render Settings page
2. Refresh the page (Ctrl+R)
3. Do you still see the 4 variables listed?
   ✅ Yes → Variables saved
   ❌ No → Variables didn't save (bug? try again)
```

---

### **STEP 4: Test Database Connection**
```
After environment variables are set:

1. Go to your Render service
2. Click "Manual Deploy" → "Deploy latest commit"
3. Wait 3-5 minutes for deployment
4. Once deployed, go to Logs tab
5. Look for messages:
   ✅ "✅ Database connected successfully" → Database works!
   ❌ "❌ Database connection failed" → Check credentials

If you see DB connection message, test the health endpoint:
   Visit: https://your-service.onrender.com/api/health
   You should see JSON with DB_HOST, DB_USER, etc.
```

---

### **STEP 5: Try Registration Again**
```
1. Go to https://your-service.onrender.com
2. Click "Register"
3. Fill in all fields
4. Click Register
5. Check:
   ✅ "Registration successful!" → WORKS!
   ❌ Error message → Database still not connected
```

---

## 🆘 **IF STILL GETTING ERROR**

### **Reason 1: Environment Variables Not Saved**
```
Solution:
1. Go to Render Settings again
2. Check if variables are still there
3. If missing, add them again
4. After saving, click "Restart instance" button
```

### **Reason 2: Supabase Firewall Blocking Render**
```
Solution (if Supabase has IP whitelist):
1. Go to Supabase → Settings → Network/Security
2. Look for "IP Whitelist" or "Firewall"
3. Add: 0.0.0.0/0 (allow all) or find Render's IP
4. Save
5. Redeploy on Render
```

### **Reason 3: Wrong Database Credentials**
```
Solution:
1. Double-check Supabase credentials
2. Make sure password doesn't have special characters
3. If it does, try resetting password in Supabase
4. Use new password on Render
5. Redeploy
```

### **Reason 4: Database Schema Not Created**
```
Solution:
1. Go to Supabase → SQL Editor
2. Click "New Query"
3. Copy entire contents of database-schema.sql
4. Paste into Supabase
5. Click "Run"
6. Check for errors in output
7. Redeploy Render app
```

---

## 📋 **CHECKLIST - DO THIS IN ORDER**

- [ ] Created Supabase project
- [ ] Ran database-schema.sql in Supabase  
- [ ] Have Supabase connection details written down
- [ ] Added DB_HOST to Render Environment
- [ ] Added DB_USER to Render Environment
- [ ] Added DB_PASSWORD to Render Environment
- [ ] Added DB_NAME to Render Environment
- [ ] Saved environment variables on Render
- [ ] Redeployed on Render
- [ ] Checked `/api/health` endpoint
- [ ] Saw "✅ Database connected successfully" in logs
- [ ] Tried registration again
- [ ] Registration worked!

---

## 🎯 **TAKE ACTION NOW**

1. Open Render dashboard in one tab
2. Open Supabase in another tab
3. Copy Supabase credentials
4. Paste into Render environment variables
5. Redeploy
6. Test

**Don't proceed until environment variables are VERIFIED to be set!**

---
