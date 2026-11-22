@echo off
title Student Skill Development Platform Launcher
echo ===============================================================
echo   Starting Student Skill Development Platform (SSP)
echo ===============================================================
echo.

cd /d "%~dp0server"
echo [1/2] Launching FastAPI Backend on http://localhost:8000 ...
start "SSP Backend (FastAPI)" cmd /k "venv\Scripts\activate.bat && python run_server.py"

cd /d "%~dp0client"
echo [2/2] Launching Vite Frontend on http://localhost:5173 ...
start "SSP Frontend (Vite)" cmd /k "npm run dev"

echo.
echo ===============================================================
echo   Platform is running!
echo   👉 Login Page: http://localhost:5173/login
echo ===============================================================
timeout /t 3 >nul
start http://localhost:5173/login
