#!/bin/bash
set -e  # Exit immediately if a command fails

echo "Checking DVC artifacts..."
if [ ! -d ".dvc/cache" ]; then
    echo "Pulling DVC artifacts from S3..."
    dvc pull --remote myremote --quiet
else
    echo "DVC artifacts already present. Skipping pull."
fi

echo "Starting Flask API..."
exec python src/app.py  # Use exec to replace the shell process with Python
