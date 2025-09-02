# docker
For container development for Vivado PL development.

The docker build command using vivado-layer.Dockerfile is,
   docker build -f vivado-layer.Dockerfile -t vivado-layer:v<> .

Vivado PL development base container is obtained by,
   docker pull ghcr.io/johnmeisner/vivado-layer:v<>

vivado-base:2025.1 is the base layer

Dockerfile to be used for multi-layer docker container development.

Added new vivado_docker_setup.sh script that needs to be run prior to building the vivado docker container which
requires auth token and .lic license file.  User needs to obtain from AMD.

Updated: 9/2/25
