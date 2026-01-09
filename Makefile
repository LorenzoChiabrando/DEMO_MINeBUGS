# --- CONFIGURATION ---
FLAG_FILE := .seeded

.PHONY: up down clean logs shell help

default: up

# --- LIFECYCLE COMMANDS ---

# Start application
up:
	@if [ ! -f $(FLAG_FILE) ]; then \
		echo "First run detected. Initializing..."; \
		docker compose --profile init up -d; \
		touch $(FLAG_FILE); \
		echo "Initialization complete."; \
	else \
		echo "Starting services..."; \
		docker compose up -d; \
		echo "Services started."; \
	fi

# Stop application
down:
	@echo "Stopping services..."
	docker compose down

# Full reset (destroys data and state)
clean:
	@echo "Resetting environment..."
	docker compose down -v
	rm -f $(FLAG_FILE)
	@echo "Environment cleaned."

# --- UTILITIES ---

# View logs
logs:
	docker compose logs -f

# Access DB shell
db-shell:
	docker compose exec db psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}
