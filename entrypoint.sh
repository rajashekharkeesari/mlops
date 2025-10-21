#!/bin/bash
set -e  # exit immediately if a command fails

echo "🚀 Starting container entrypoint..."

# ---------------------------
# 1️⃣ Check if AWS credentials are configured
# ---------------------------
if [ -z "$AWS_ACCESS_KEY_ID" ] && [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "⚠️  No AWS credentials detected. Assuming IAM Role or anonymous access..."
else
  echo "✅ AWS credentials detected via environment variables."
fi

# ---------------------------
# 2️⃣ Pull DVC artifacts from remote (S3 or other)
# ---------------------------
REMOTE_NAME=${DVC_REMOTE:-myremote}

echo "📦 Pulling DVC artifacts from remote: $REMOTE_NAME ..."
if ! dvc pull --remote "$REMOTE_NAME" --quiet; then
  echo "❌ DVC pull failed — please verify your remote name and credentials."
  exit 1
fi
echo "✅ DVC artifacts successfully pulled."

# ---------------------------
# 3️⃣ Start Flask API
# ---------------------------
echo "🌐 Starting Flask API..."
exec python src/app.py
