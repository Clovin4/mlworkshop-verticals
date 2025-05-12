#!/usr/bin/env bash

echo "***************  Launching MLFlow Server  ***************"

mlflow server \
    --backend-store-uri postgresql+psycopg2://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/mlflowdb \
    --default-artifact-root s3://your_bucket_name \
    --host 0.0.0.0 \
    --port 5000
