#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <project_name>"
  exit 1
fi

PROJECT_NAME="$1"
TEMPLATE_DIR="./0-template"
TARGET_DIR="./$PROJECT_NAME"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Template directory '$TEMPLATE_DIR' not found!"
  exit 1
fi

if [ -d "$TARGET_DIR" ]; then
  echo "Target directory '$TARGET_DIR' already exists!"
  exit 1
fi

cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

rm -rf "$TARGET_DIR/out"

ENV_FILE="$TARGET_DIR/.env"

if [ -f "$ENV_FILE" ]; then
  sed -i "s/^PROJECT_NAME=.*/PROJECT_NAME=$PROJECT_NAME/" "$ENV_FILE"
else
  echo "PROJECT_NAME=$PROJECT_NAME" > "$ENV_FILE"
fi

printf "\033[34mProject '$PROJECT_NAME' created successfully.\033[0m\n"

"$TARGET_DIR/build.sh"
