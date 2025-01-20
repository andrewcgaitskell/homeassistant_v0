# How to start ha supervisor
    systemctl status hassio-supervisor.service
    systemctl start hassio-supervisor.service
    systemctl status hassio-apparmor.service
    systemctl start hassio-apparmor.service
    systemctl status haos-agent.service
    systemctl start haos-agent.service
    docker update --restart=yes hassio_observer

# How to stop and disable ha supervisor
    systemctl status hassio-supervisor.service
    systemctl stop hassio-supervisor.service
    systemctl disable hassio-supervisor.service
    systemctl status hassio-apparmor.service
    systemctl stop hassio-apparmor.service
    systemctl disable hassio-apparmor.service
    systemctl status haos-agent.service
    systemctl stop haos-agent.service
    systemctl disable haos-agent.service
    docker stop hassio_observer
    docker update --restart=no hassio_observer
