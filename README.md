# docker
For container development for Vivado PL development.

The docker build command using vivado-layer.Dockerfile is,

   docker build -f vivado-layer.Dockerfile -t vivado-layer:v1 .

and Vivado PL development base container is obtained by,

   docker pull ghcr.io/johnmeisner/vivado-layer:v1
