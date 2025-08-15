#!/bin/bash

# 1. Welcome message and prerequisites
echo "Welcome! This script will help you set up a Vivado Docker container."
echo "Prerequisites:"
echo " - You have a Xilinx/AMD account."
echo " - You have obtained a Vivado authentication token from the Xilinx portal."
echo " - You have downloaded your Vivado license file (.lic)."
echo ""

# 2. Prompt for authentication token
read -p "Paste your Vivado authentication token: " AUTH_TOKEN

# 3. Prompt for Vivado license file path
read -p "Enter the path to your Vivado license file (.lic): " LICENSE_PATH

# 4. Docker build (assuming Dockerfile is configured to accept AUTH_TOKEN)
echo "Building Vivado Docker image..."
docker build --build-arg AUTH_TOKEN="$AUTH_TOKEN" -t vivado-image .

# 5. Run the container with license file mounted
echo "Starting Vivado Docker container..."
docker run -it \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$LICENSE_PATH":/home/vivado/.Xilinx/license.lic \
    vivado-image

echo "Vivado container started. If you see the Vivado GUI, you're ready to go!"
