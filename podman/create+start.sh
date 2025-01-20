podman run -d \
  --name homeassistant \
  --privileged \
  --restart=unless-stopped \
  -e TZ=Etc/GMT \
  -v /home/pi5ha/ha/config:/config \
  -v /run/dbus:/run/dbus:ro \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable

  
