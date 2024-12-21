podman build -t python-matter-server .

podman run -d -p 5555:5555 --name matter_server python-matter-server
