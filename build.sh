#!/bin/bash
set -e

echo "=========================================="
echo "HireWay Build Script"
echo "=========================================="

echo ""
echo "Step 1: Installing dependencies..."
npm ci || npm install

echo ""
echo "Step 2: Building React application..."
npm run build

echo ""
echo "=========================================="
echo "Build completed successfully!"
echo "=========================================="
