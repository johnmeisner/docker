#!/bin/bash

echo "Welcome! This script will help you set up a Vivado Docker container."
echo "You need:"
echo " - A Xilinx/AMD account"
echo " - A Vivado authentication token (get this from the Xilinx portal)"
echo " - Your Vivado license file (.lic)"
echo ""

read -p "Paste your Vivado authentication token: " AUTH_TOKEN

echo ""
echo "IMPORTANT:"
echo "The Vivado authentication token is valid only for a short period—usually less than an hour."
echo "Start the Docker build now. If the build fails due to token expiration, just generate a new token and rerun the build."
echo ""

read -p "Enter the path to your Vivado license file (.lic): " LICENSE_PATH

docker build --build-arg AUTH_TOKEN="$AUTH_TOKEN" -t vivado-image .
docker run -it \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "$LICENSE_PATH":/home/vivado/.Xilinx/license.lic \
    vivado-image
