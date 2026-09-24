@echo off
title Multimodal Chest X-ray Diagnostic System
cd /d "%~dp0"

echo ======================================================================
echo       MULTIMODAL CHEST X-RAY WEB APPLICATION RUNNER
echo ======================================================================
echo.

:: 1. Check Python installation
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not found in your PATH.
    echo Please install Python 3.10 or 3.11 and check "Add Python to PATH".
    echo Download: https://www.python.org/downloads/
    pause
    exit /b 1
)

:: 2. Check virtual environment
if not exist "venv\Scripts\activate.bat" (
    echo [INFO] Virtual environment not found. Creating venv...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create virtual environment.
        pause
        exit /b 1
    )
    echo [INFO] Activating virtual environment...
    call venv\Scripts\activate.bat
    echo [INFO] Installing required dependencies...
    python -m pip install --upgrade pip
    pip install -r requirements.txt
) else (
    echo [INFO] Activating existing virtual environment...
    call venv\Scripts\activate.bat
)

:: 3. Launch Flask application
echo.
echo ======================================================================
echo [INFO] Starting Flask Server...
echo [INFO] Once started, open your browser and navigate to:
echo        http://127.0.0.1:5000
echo ======================================================================
echo.

python src/web/app.py

pause
