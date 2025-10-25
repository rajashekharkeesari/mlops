#!/bin/bash
set -e

echo "Checking DVC artifacts..."
if [ ! -d "/app/.dvc/cache" ]; then
    echo "Pulling DVC artifacts from S3..."
    dvc pull --remote myremote --quiet
fi

echo "Starting MLflow server..."
mlflow server --host 0.0.0.0 --port 5000 \
  --backend-store-uri /app/mlruns \
  --default-artifact-root /app/mlruns &

echo "Starting Flask API..."
exec python /app/app.py
