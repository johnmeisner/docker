import os
import subprocess

def run_gui_container(command="xeyes"):

    """
    Launches a Docker container with GUI support and runs the specified command.
    The container used is ghcr.io/johnmeisner/vivado-layer:v3.
    """

    docker_cmd = [
        "docker", "run", "-it", "--rm",
        "-e", f"DISPLAY={os.environ.get('DISPLAY', ':0')}",
        "-v", "/tmp/.X11-unix:/tmp/.X11-unix",
        "-e", "XAUTHORITY=/home/johnm/.Xauthority",
        "-v", f"{os.environ['HOME']}/.Xauthority:/home/johnm/.Xauthority",
        "--user", f"{os.getuid()}:{os.getgid()}",
        "ghcr.io/johnmeisner/vivado-layer:v3", command
    ]

    subprocess.run(docker_cmd)

# Example usage

if __name__ == "__main__":
    run_gui_container("xeyes")  # You can replace "xeyes" with "vivado" or any other GUI command
