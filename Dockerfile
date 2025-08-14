# Dockerfile
# This Dockerfile builds an image with a base Ubuntu layer, GUI dependencies,
# and the Vivado Design Suite installed.

# Use a base image with a minimal Ubuntu installation.
# This assumes ghcr.io/johnmeisner/vivado-base:2025.1 is an Ubuntu-based image.
FROM ghcr.io/johnmeisner/vivado-base:2025.1

LABEL maintainer="John Meisner <jhnmsnr@gmail.com>"
LABEL description="Vivado layer with GUI dependencies and Vivado installation for IPI and PL workflows"

# Define build arguments for the user's UID and GID.
# Default values are set to 1000, which is common.
ARG HOST_UID=1000
ARG HOST_GID=1000

# Create a non-root user that matches the host user's UID and GID.
# This is critical for X11 forwarding and file permissions.
RUN groupadd --gid $HOST_GID vivado && \
    useradd -m -s /bin/bash --uid $HOST_UID --gid $HOST_GID vivado

# Install GUI dependencies required for X11 forwarding.
RUN apt-get update && apt-get install -y \
    xauth \
    x11-apps \
    libgtk-3-0 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies needed by the Vivado installer itself.
# These libraries are often required for graphical installers and tools.
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    unzip \
    libncurses5-dev \
    libxml2 \
    libudev1 \
    libgconf-2-4 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Define an authentication token as a build-arg for the web installer.
#ARG AUTH_TOKEN

# Copy the Vivado Web Installer and the batch configuration file from the build context.
# NOTE: Both files must be in the same directory as this Dockerfile.
#COPY FPGAs_AdaptiveSoCs_Unified_SDI_2025.1_0530_0145_Lin64.bin /tmp/vivado-installer.bin
#COPY vivado_install_config.txt /tmp/vivado_install_config.txt

# Create the installation directory and run the Vivado installer in batch mode.
# The installer is first made executable, extracts its contents, and then runs the `xsetup` utility.
# The `--agree` flag is used to accept the EULA, and the `--authentication-token` is passed for web access.
# Finally, all temporary installer files are removed to reduce the image size.
#RUN mkdir -p /opt/Xilinx \
#    && chmod +x /tmp/vivado-installer.bin \
#    && /tmp/vivado-installer.bin --nox11 --tar xf -C /tmp/ \
#    && /tmp/xsetup --agree XilinxEULA,3rdPartyEULA -b Install -c /tmp/vivado_install_config.txt --authentication-token $AUTH_TOKEN \
#    && rm -f /tmp/vivado-installer.bin \
#    && rm -f /tmp/vivado_install_config.txt \
#    && rm -rf /tmp/xsetup*

# Set the PATH and required environment variables so Vivado commands are easily accessible.
#ENV PATH="/opt/Xilinx/Vivado/2025.1/bin:$PATH"
#ENV LD_LIBRARY_PATH="/opt/Xilinx/Vivado/2025.1/lib/lnx64.o/:$LD_LIBRARY_PATH"

# Set the container's user to the non-root 'vivado' user.
# This is important for security and for correct X11 forwarding.
#USER vivado

# Set the default command to launch the Vivado GUI when the container starts.
#CMD ["vivado"]
