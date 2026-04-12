@echo off
REM ==============================================================================
REM MINeBUGS DEMO - VERBOSE STARTUP SCRIPT (WINDOWS)
REM ==============================================================================

set COMPOSE_FILE=docker-compose.yml

echo ==================================================
echo    MINeBUGS DEMO - SYSTEM INITIALIZATION
echo ==================================================
echo.
echo WARNING: If the terminal seems to freeze for too long,
echo press the "ENTER" key on your keyboard to ensure
echo it is not paused (Windows QuickEdit feature).
echo.

echo [1/5] Checking Docker status...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker is not running or not responding.
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)
echo [OK] Docker is active!
echo.

echo [2/5] Checking configuration file...
if not exist "%COMPOSE_FILE%" (
    echo [ERROR] File '%COMPOSE_FILE%' not found.
    echo Make sure you are running this script from the 'demo/' directory.
    pause
    exit /b 1
)
echo [OK] docker-compose file found!
echo.

echo [3/5] Downloading images (Pulling)...
echo This operation may take several minutes. Please wait...
echo ----------------------------------------------------------------
docker compose -f "%COMPOSE_FILE%" pull
echo ----------------------------------------------------------------
echo [OK] Download phase completed!
echo.

echo [4/5] Creating and starting containers in the background...
echo ----------------------------------------------------------------
docker compose -f "%COMPOSE_FILE%" up -d
if %errorlevel% neq 0 (
    echo [ERROR] Unable to start services. Check the errors above.
    pause
    exit /b 1
)
echo ----------------------------------------------------------------
echo [OK] Containers started successfully!
echo.

echo [5/5] Checking current container status:
docker compose -f "%COMPOSE_FILE%" ps
echo.

echo ==================================================
echo DATABASE CONFIGURATION MONITORING
echo ==================================================
echo The system is configuring Keycloak and populating data.
echo When you see that the seeder has finished its job,
echo the application will be available at: http://localhost:80
echo.
echo (Press CTRL+C to exit this log view at any time)
echo ----------------------------------------------------------------

docker compose -f "%COMPOSE_FILE%" logs -f minebugs-db-seeder

echo.
pause
