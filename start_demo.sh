#!/bin/bash

# ==============================================================================
# MINeBUGS DEMO - AUTOMATED STARTUP SCRIPT
# ==============================================================================

COMPOSE_FILE="docker-compose.prod.yml"

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

if ! docker info > /dev/null 2>&1; then
  echo "Error: Docker daemon is not running."
  echo "Please start Docker Desktop/Engine and try again."
  exit 1
fi

if [ ! -f "$COMPOSE_FILE" ]; then
    echo "Error: Configuration file '$COMPOSE_FILE' not found."
    echo "Please ensure you are in the project root directory."
    exit 1
fi

docker compose -f "$COMPOSE_FILE" pull

if [ $? -ne 0 ]; then
    echo "Warning: Failed to pull latest images. Attempting to start with local versions..."
fi

echo "   Starting services..."

docker compose -f "$COMPOSE_FILE" up -d

if [ $? -ne 0 ]; then
    echo "Error: Failed to start services."
    exit 1
fi

echo ""
echo "2. Monitoring Data Seeding Progress..."
echo "   The system is downloading necessary reference data (2.4 GB)."
echo "   Please wait until the process completes."
echo "   (Press CTRL+C to exit this log view at any time)"
echo "----------------------------------------------------------------"

# Follow the logs of the minio-seeder service
docker compose -f "$COMPOSE_FILE" logs -f minio-seeder

echo ""
echo "=================================================="
echo "   SYSTEM OPERATIONAL"
echo "=================================================="
echo "   Application URL: http://localhost:80"
echo "=================================================="
echo ""
