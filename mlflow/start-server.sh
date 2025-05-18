#!/bin/bash

# Load secrets from _FILE vars if available and not already set
if [[ -z "$POSTGRES_PASSWORD" && -n "$POSTGRES_PASSWORD_FILE" && -f "$POSTGRES_PASSWORD_FILE" ]]; then
  POSTGRES_PASSWORD=$(<"$POSTGRES_PASSWORD_FILE")
fi

if [[ -z "$AWS_ACCESS_KEY_ID" && -n "$AWS_ACCESS_KEY_ID_FILE" && -f "$AWS_ACCESS_KEY_ID_FILE" ]]; then
  AWS_ACCESS_KEY_ID=$(<"$AWS_ACCESS_KEY_ID_FILE")
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" && -n "$AWS_SECRET_ACCESS_KEY_FILE" && -f "$AWS_SECRET_ACCESS_KEY_FILE" ]]; then
  AWS_SECRET_ACCESS_KEY=$(<"$AWS_SECRET_ACCESS_KEY_FILE")
fi

# Run MLflow
mlflow server \
  --backend-store-uri postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@postgres:5432/${MLFLOW_POSTGRES_DB} \
  --default-artifact-root ${MLFLOW_S3_ENDPOINT_URL}/${MLFLOW_ARTIFACT_BUCKET} \
  --host 0.0.0.0 \
  --port 5000
