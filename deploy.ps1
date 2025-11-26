# HireWay Deployment Helper for Windows PowerShell

Write-Host "=== HireWay Deployment Helper ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Choose your deployment platform:" -ForegroundColor Yellow
Write-Host "1. Vercel (Frontend)"
Write-Host "2. Railway (Backend)"
Write-Host "3. Render (Backend)"
Write-Host "4. Heroku (Backend)"
Write-Host "5. Build Frontend"
Write-Host "6. Start Backend Locally"
Write-Host ""
$choice = Read-Host "Enter your choice (1-6)"

switch ($choice) {
    "1" {
        Write-Host "Deploying Frontend to Vercel..." -ForegroundColor Green
        Write-Host "Install Vercel CLI: npm i -g vercel" -ForegroundColor Yellow
        Write-Host "Then run: vercel" -ForegroundColor Yellow
        Write-Host "Follow the prompts to deploy" -ForegroundColor Yellow
    }
    "2" {
        Write-Host "Deploying Backend to Railway..." -ForegroundColor Green
        Write-Host "1. Go to railway.app" -ForegroundColor Yellow
        Write-Host "2. Create new project"
        Write-Host "3. Connect your GitHub repository"
        Write-Host "4. Set environment variables in dashboard"
        Write-Host "5. Deploy!"
    }
    "3" {
        Write-Host "Deploying Backend to Render..." -ForegroundColor Green
        Write-Host "1. Go to render.com" -ForegroundColor Yellow
        Write-Host "2. Create new Web Service"
        Write-Host "3. Connect GitHub repository"
        Write-Host "4. Set environment variables"
        Write-Host "5. Deploy!"
    }
    "4" {
        Write-Host "Deploying Backend to Heroku..." -ForegroundColor Green
        Write-Host "1. Install Heroku CLI: npm i -g heroku" -ForegroundColor Yellow
        Write-Host "2. Login: heroku login"
        Write-Host "3. Create app: heroku create hireway-backend"
        Write-Host "4. Set env vars: heroku config:set DB_HOST=..."
        Write-Host "5. Push: git push heroku main"
    }
    "5" {
        Write-Host "Building Frontend..." -ForegroundColor Green
        npm run build
        Write-Host "Build complete! Output in './build' folder" -ForegroundColor Green
    }
    "6" {
        Write-Host "Starting Backend Locally..." -ForegroundColor Green
        Set-Location backend
        npm start
    }
    default {
        Write-Host "Invalid choice!" -ForegroundColor Red
    }
}
