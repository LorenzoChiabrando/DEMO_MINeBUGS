#!/bin/bash

# ==============================================================================
# MINeBUGS DEMO - VERBOSE STARTUP SCRIPT (LINUX/MAC)
# ==============================================================================

COMPOSE_FILE="docker-compose.yml"

# Gestione pulita dell'uscita con CTRL+C
cleanup() {
    echo ""
    echo "----------------------------------------------------------------"
    echo "Log monitoring interrupted."
    echo "The containers are still running in the background."
    echo "To shut down the environment, please execute:"
    echo "   docker compose -f $COMPOSE_FILE down"
    echo "----------------------------------------------------------------"
    exit 0
}

trap cleanup INT

echo "=================================================="
echo "   MINeBUGS DEMO - SYSTEM INITIALIZATION"
echo "=================================================="
echo ""

echo "[1/5] Checking Docker status..."
if ! docker info > /dev/null 2>&1; then
  echo "[ERROR] Docker is not running or not responding."
  echo "Please start Docker Desktop/Engine and try again."
  exit 1
fi
echo "[OK] Docker is active!"
echo ""

echo "[2/5] Checking configuration file..."
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "[ERROR] File '$COMPOSE_FILE' not found."
    echo "Make sure you are running this script from the 'demo/' directory."
    exit 1
fi
echo "[OK] docker-compose file found!"
echo ""

echo "[3/5] Downloading images (Pulling)..."
echo "This operation may take several minutes. Please wait..."
echo "----------------------------------------------------------------"
docker compose -f "$COMPOSE_FILE" pull
echo "----------------------------------------------------------------"
echo "[OK] Download phase completed!"
echo ""

echo "[4/5] Creating and starting containers in the background..."
echo "----------------------------------------------------------------"
if ! docker compose -f "$COMPOSE_FILE" up -d; then
    echo "[ERROR] Unable to start services. Check the errors above."
    exit 1
fi
echo "----------------------------------------------------------------"
echo "[OK] Containers started successfully!"
echo ""

echo "[5/5] Checking current container status:"
docker compose -f "$COMPOSE_FILE" ps
echo ""

echo "=================================================="
echo "DATABASE CONFIGURATION MONITORING"
echo "=================================================="
echo "The system is configuring Keycloak and populating data."
echo "When you see that the seeder has finished its job,"
echo "the application will be available at: http://localhost:80"
echo ""
echo "(Press CTRL+C to exit this log view at any time)"
echo "----------------------------------------------------------------"

docker compose -f "$COMPOSE_FILE" logs -f minebugs-db-seeder

echo ""