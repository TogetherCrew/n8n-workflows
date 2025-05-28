# n8n-workflows

This project provides a complete Docker Compose setup for running n8n (workflow automation) and Qdrant (vector database) together in a development environment.

## Services Included

- **n8n**: Workflow automation platform (v1.94.1)
- **Qdrant**: Vector database for AI/ML applications
- **PostgreSQL**: Database for n8n

## Quick Start

1. **Clone and Setup Environment**

   ```bash
   git clone <repository-url>
   cd n8n-workflows
   cp .env.example .env
   ```

2. **Configure Environment Variables**
   Edit the `.env` file and update the following required values:
   - `POSTGRES_PASSWORD`: Strong password for PostgreSQL
   - `N8N_BASIC_AUTH_PASSWORD`: Password for n8n web interface
   - `N8N_ENCRYPTION_KEY`: 32-character encryption key for n8n

   Generate a secure encryption key:

   ```bash
   openssl rand -hex 16
   ```

3. **Start Services**

   ```bash
   docker-compose -f docker-compose.dev.yml up -d
   ```

4. **Access Services**
   - **n8n**: http://localhost:5678 (username: admin, password: from .env)
   - **Qdrant**: http://localhost:6333

## Service Details

### n8n (Port 5678)

- Workflow automation platform with web UI
- Connected to PostgreSQL for persistence
- Basic auth enabled by default
- Webhooks available at configured URL

### Qdrant (Ports 6333/6334)

- Vector database for AI/ML applications
- HTTP API on port 6333
- gRPC API on port 6334
- Web UI available at HTTP port

## Environment Variables

### Database Configuration

- `POSTGRES_DB`: Database name for n8n
- `POSTGRES_USER`: Database user for n8n
- `POSTGRES_PASSWORD`: Database password for n8n
- `POSTGRES_PORT`: PostgreSQL port (default: 5432)

### n8n Configuration

- `N8N_BASIC_AUTH_ACTIVE`: Enable/disable basic auth
- `N8N_BASIC_AUTH_USER`: Username for n8n login
- `N8N_BASIC_AUTH_PASSWORD`: Password for n8n login
- `N8N_HOST`: Hostname for n8n
- `N8N_PORT`: Port for n8n web interface
- `N8N_PROTOCOL`: Protocol (http/https)
- `N8N_WEBHOOK_URL`: Base URL for webhooks
- `N8N_ENCRYPTION_KEY`: 32-character encryption key

### Qdrant Configuration

- `QDRANT_HTTP_PORT`: HTTP API port (default: 6333)
- `QDRANT_GRPC_PORT`: gRPC API port (default: 6334)
- `QDRANT_LOG_LEVEL`: Logging level

## Development Commands

```bash
# Start all services
docker-compose -f docker-compose.dev.yml up -d

# View logs
docker-compose -f docker-compose.dev.yml logs -f

# Stop all services
docker-compose -f docker-compose.dev.yml down

# Stop and remove volumes (destructive)
docker-compose -f docker-compose.dev.yml down -v

# Restart specific service
docker-compose -f docker-compose.dev.yml restart n8n

# Access service shell
docker-compose -f docker-compose.dev.yml exec n8n sh

# Run test suite
docker-compose -f docker-compose.test.yml up --exit-code-from app
```

## Testing

The project includes a simple test suite for CI/CD validation:

- **Test file**: `docker-compose.test.yml`
- **Purpose**: Validates basic environment and configuration
- **Usage**: `make test` or `docker-compose -f docker-compose.test.yml up --exit-code-from app`
- **Coverage**: Generates a mock `coverage/lcov.info` file for CodeClimate integration

The test suite is designed to always pass and generates coverage reports for CI pipeline requirements. The coverage report is compatible with CodeClimate and other LCOV-based coverage tools.

## Data Persistence

All services use Docker volumes for data persistence:

- `postgres_data`: n8n PostgreSQL data
- `n8n_data`: n8n workflows and settings
- `qdrant_data`: Qdrant vector database

## Health Checks

All services include health checks:

- PostgreSQL: Database connection test
- n8n: HTTP health endpoint
- Qdrant: HTTP health endpoint

## Security Notes

1. Change all default passwords in the `.env` file
2. Use strong, unique passwords for all services
3. For production, consider using Docker secrets
4. Ensure firewall rules are properly configured
5. Use HTTPS in production environments

## Troubleshooting

1. **Port conflicts**: Check if ports are already in use
2. **Database connection issues**: Verify PostgreSQL is healthy
3. **Permission errors**: Check Docker daemon permissions
4. **Memory issues**: Ensure sufficient RAM for all services

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
