-- Create n8n database if it doesn't exist
CREATE DATABASE n8n;

-- Grant all privileges to the n8n user
GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n_user;
