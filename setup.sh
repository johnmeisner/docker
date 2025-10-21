# Make sure you are in the directory with the installer
cd ~/test/docker/Test3

rm ./wi_authentication_key

# Create a temporary directory for extraction
mkdir -p vivado-installer-tmp

# Extract the contents without running the installer script
./FPGAs_AdaptiveSoCs_Unified_SDI_2025.1_0530_0145_Lin64.bin --noexec --keep --target ./vivado-installer-tmp

# Run the interactive token generator
#../vivado-installer-tmp/xsetup -b AuthTokenGen
vivado-installer-tmp/xsetup -b AuthTokenGen

# Copy the newly generated token from ~/.Xilinx to the current directory
cp ~/.Xilinx/wi_authentication_key .

xhost +local:docker
