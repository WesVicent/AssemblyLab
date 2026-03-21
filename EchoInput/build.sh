#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

if [ -f "$ENV_FILE" ]; then
  export $(grep -v '^#' "$ENV_FILE" | xargs)
else
  echo ".env file not found at $ENV_FILE"
  exit 1
fi

if [ -z "$PROJECT_NAME" ]; then
  echo "PROJECT_NAME is not set in .env"
  exit 1
fi

cmake -S "$SCRIPT_DIR" -B "$SCRIPT_DIR/out"
cmake --build "$SCRIPT_DIR/out"

"$SCRIPT_DIR/out/bin/$PROJECT_NAME"