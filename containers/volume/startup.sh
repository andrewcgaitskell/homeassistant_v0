#!/bin/sh

# Directory and file test paths
TEST_DIR="/data/test_dir"
TEST_FILE="/data/test_file.txt"

echo "Testing directory creation..."
mkdir -p "$TEST_DIR"
if [ $? -eq 0 ]; then
  echo "Directory created successfully: $TEST_DIR"
else
  echo "Failed to create directory: $TEST_DIR"
  exit 1
fi

echo "Testing file creation..."
echo "Hello, Podman!" > "$TEST_FILE"
if [ $? -eq 0 ]; then
  echo "File created successfully: $TEST_FILE"
  echo "File content:"
  cat "$TEST_FILE"
else
  echo "Failed to create file: $TEST_FILE"
  exit 1
fi


