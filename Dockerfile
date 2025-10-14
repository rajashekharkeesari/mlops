# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy project files into the image
COPY . .

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install DVC
RUN pip install --no-cache-dir dvc[all] mlflow

# Default command: run the DVC pipeline
CMD ["dvc", "repro"]
