@echo off
echo 🔄 Installing frontend dependencies...
cd client
call npm install

echo ✅ Frontend dependencies installed.
echo 🚀 Starting frontend dev server...
start "" npm run serve
cd ..

echo 🔄 Building and starting backend (.NET Core)...
cd server
dotnet restore
dotnet run

pause