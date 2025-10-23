# -------------------------
# Base image
# -------------------------
FROM python:3.10-slim

# -------------------------
# Set working directory
# -------------------------
WORKDIR /app

# -------------------------
# Install system dependencies
# -------------------------
RUN apt-get update && \
    apt-get install -y git curl dos2unix && \
    rm -rf /var/lib/apt/lists/*

# -------------------------
# Copy project files
# -------------------------
COPY . .

# -------------------------
# Convert entrypoint to Unix and make executable
# -------------------------
RUN dos2unix /app/entrypoint.sh && chmod +x /app/entrypoint.sh

# -------------------------
# Install Python dependencies
# -------------------------
RUN pip install --no-cache-dir --default-timeout=100 -r requirements.txt && \
    pip install --no-cache-dir --default-timeout=100 dvc[all] mlflow

# -------------------------
# Expose Flask port
# -------------------------
EXPOSE 8080

# -------------------------
# Entrypoint
# -------------------------
ENTRYPOINT ["/app/entrypoint.sh"]
