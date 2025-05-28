.PHONY: help start stop restart logs clean setup health status

# Default target
help:
	@echo "Available commands:"
	@echo "  setup     - Copy .env.example to .env for first-time setup"
	@echo "  start     - Start all services"
	@echo "  stop      - Stop all services"
	@echo "  restart   - Restart all services"
	@echo "  logs      - Show logs for all services"
	@echo "  health    - Check health status of all services"
	@echo "  status    - Show status of all services"
	@echo "  clean     - Stop services and remove volumes (destructive)"
	@echo ""
	@echo "Service-specific commands:"
	@echo "  n8n-logs     - Show n8n logs"
	@echo "  qdrant-logs  - Show Qdrant logs"

# Setup environment
setup:
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "Created .env file from .env.example"; \
		echo "Please edit .env file with your configuration"; \
	else \
		echo ".env file already exists"; \
	fi

# Start all services
start:
	docker-compose -f docker-compose.dev.yml up -d

# Stop all services
stop:
	docker-compose -f docker-compose.dev.yml down

# Restart all services
restart:
	docker-compose -f docker-compose.dev.yml restart

# Show logs for all services
logs:
	docker-compose -f docker-compose.dev.yml logs -f

# Check health status
health:
	@echo "Checking service health..."
	@docker-compose -f docker-compose.dev.yml ps

# Show service status
status:
	docker-compose -f docker-compose.dev.yml ps

# Clean up (destructive - removes volumes)
clean:
	docker-compose -f docker-compose.dev.yml down -v
	docker system prune -f

# Service-specific logs
n8n-logs:
	docker-compose -f docker-compose.dev.yml logs -f n8n

qdrant-logs:
	docker-compose -f docker-compose.dev.yml logs -f qdrant 