# vivado-x11.Dockerfile
FROM ghcr.io/johnmeisner/vivado-base:2025.1

LABEL maintainer="John Meisner <jhnmsnr@gmail.com>"
LABEL description="Vivado layer with GUI dependencies only for IPI and PL workflows"

RUN apt-get update && apt-get install -y \
    xauth \
    x11-apps \
    libgtk-3-0 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
 && rm -rf /var/lib/apt/lists/*
