#!/bin/bash

# HireWay Deployment Script
# This script helps deploy the application to various cloud platforms

echo "=== HireWay Deployment Helper ==="
echo ""
echo "Choose your deployment platform:"
echo "1. Vercel (Frontend)"
echo "2. Railway (Backend)"
echo "3. Render (Backend)"
echo "4. Heroku (Backend)"
echo "5. Deploy All"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
  1)
    echo "Deploying Frontend to Vercel..."
    echo "Install Vercel CLI: npm i -g vercel"
    echo "Then run: vercel"
    ;;
  2)
    echo "Deploying Backend to Railway..."
    echo "1. Go to railway.app"
    echo "2. Connect your GitHub repository"
    echo "3. Set environment variables in dashboard"
    echo "4. Deploy!"
    ;;
  3)
    echo "Deploying Backend to Render..."
    echo "1. Go to render.com"
    echo "2. Create new Web Service"
    echo "3. Connect GitHub repository"
    echo "4. Set environment variables"
    echo "5. Deploy!"
    ;;
  4)
    echo "Deploying Backend to Heroku..."
    echo "1. Install Heroku CLI: npm i -g heroku"
    echo "2. Login: heroku login"
    echo "3. Create app: heroku create hireway-backend"
    echo "4. Set env vars: heroku config:set DB_HOST=..."
    echo "5. Push: git push heroku main"
    ;;
  5)
    echo "Full deployment process..."
    echo "1. Build frontend: npm run build"
    echo "2. Deploy frontend to Vercel"
    echo "3. Deploy backend to Railway/Render/Heroku"
    echo "4. Update REACT_APP_API_BASE_URL in Vercel"
    ;;
  *)
    echo "Invalid choice!"
    ;;
esac
