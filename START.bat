@echo off
title SSP Launcher
color 0A

echo.
echo  ============================================
echo    Student Skill Development Platform
echo  ============================================
echo.
echo  Starting servers... please wait...
echo.

REM Kill anything on port 5173 or 8000 first
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8000"') do taskkill /PID %%a /F >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":5173"') do taskkill /PID %%a /F >nul 2>&1

REM Start Backend
echo  [1/2] Starting FastAPI Backend on port 8000...
start "SSP Backend" cmd /k "cd /d D:\Student Skill Development Platform\server && venv\Scripts\activate.bat && python run_server.py"

REM Wait 3 seconds for backend to boot
timeout /t 3 /nobreak >nul

REM Start Frontend
echo  [2/2] Starting Vite Frontend on port 5173...
start "SSP Frontend" cmd /k "cd /d D:\Student Skill Development Platform\client && npm run dev"

REM Wait 5 seconds for vite to boot
timeout /t 5 /nobreak >nul

echo.
echo  ============================================
echo   DONE! Opening browser...
echo   Login:   http://localhost:5173/login
echo   Student: http://localhost:5173/student
echo  ============================================
echo.

start "" http://localhost:5173/login

pause
