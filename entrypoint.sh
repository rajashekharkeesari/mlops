#!/bin/bash
set -e

echo "Pulling DVC artifacts from S3..."
dvc pull --remote myremote --force --quiet

echo "Starting Flask API..."
python src/app.py
