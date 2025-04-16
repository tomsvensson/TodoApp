#!/bin/bash

# Install frontend dependencies
echo "🔄 Installing frontend dependencies..."
cd client
npm install

echo "✅ Frontend dependencies installed."
echo "🚀 Starting frontend dev server..."
npm run serve &   # Start frontend in background
cd ..

# Build and start backend (.NET Core)
echo "🔄 Building and starting backend (.NET Core)..."
cd server
dotnet restore
dotnet run
cd ..

# Keep the terminal open (if you need this, optional for macOS)
read -p "Press any key to exit..."