# -------------------------
# Base image
# -------------------------
FROM python:3.10-slim

# -------------------------
# Set working directory
# -------------------------
WORKDIR /app

# -------------------------
# Copy project files
# -------------------------
COPY . .

# -------------------------
# Install system dependencies
# -------------------------
RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

# -------------------------
# Install Python dependencies
# -------------------------
RUN pip install --no-cache-dir --default-timeout=100 -r requirements.txt
RUN pip install --no-cache-dir --default-timeout=100 dvc[all] mlflow


# -------------------------
# Expose Flask port
# -------------------------
EXPOSE 8080

# -------------------------
# Entrypoint script
# -------------------------
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]
