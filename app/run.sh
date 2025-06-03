#!/usr/bin/env bash
set -e

# Define paths
VENDOR_DIR="/app/vendor"
VENV_DIR="$VENDOR_DIR/.venv"
CUSTOM_NODES_DIR="${VENDOR_DIR}/custom_nodes"

# Create the virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
  echo "Creating virtual environment..."
  python3 -m venv "$VENV_DIR"
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Upgrade pip and install base requirements if present
if [ -f "$VENDOR_DIR/requirements.txt" ]; then
  echo "Installing dependencies from vendor/requirements.txt..."
  pip install --upgrade pip
  pip install -r "$VENDOR_DIR/requirements.txt"
fi

# Loop through custom_nodes directories and install requirements.txt if present
if [ -d "$CUSTOM_NODES_DIR" ]; then
  for node_dir in "$CUSTOM_NODES_DIR"/*; do
    if [ -d "$node_dir" ] && [ -f "$node_dir/requirements.txt" ]; then
      echo "Installing dependencies from $node_dir/requirements.txt..."
      pip install -r "$node_dir/requirements.txt"
    fi
  done
fi

# Check for the RUN_COMMAND env var
if [ -z "$RUN_COMMAND" ]; then
  echo "Error: RUN_COMMAND is not set in the environment."
  exit 1
fi

echo "Executing: $RUN_COMMAND"
cd "$VENDOR_DIR"
exec bash -c "$RUN_COMMAND"
