# Important

DO NOT USE ROOTLESS DOCKER!

# Installation

https://docs.docker.com/engine/security/rootless/

# Output

ran :  dockerd-rootless-setuptool.sh install
      
      
      Creating /home/andrewcgaitskell/.config/systemd/user/docker.service
      [INFO] starting systemd service docker.service
      + systemctl --user start docker.service
      + sleep 3
      + systemctl --user --no-pager --full status docker.service
      ● docker.service - Docker Application Container Engine (Rootless)
           Loaded: loaded (/home/andrewcgaitskell/.config/systemd/user/docker.service; disabled; preset: enabled)
           Active: active (running) since Thu 2024-08-08 15:06:05 BST; 3s ago
             Docs: https://docs.docker.com/go/rootless/
         Main PID: 12246 (rootlesskit)
            Tasks: 40
              CPU: 863ms
           CGroup: /user.slice/user-1000.slice/user@1000.service/app.slice/docker.service
                   ├─12246 rootlesskit --state-dir=/run/user/1000/dockerd-rootless --net=slirp4netns --mtu=65520 --slirp4netns-sandbox=auto --slirp4netns-seccomp=auto --disable-host-loopback --port-driver=builtin --copy-up=/etc --copy-up=/run --propagation=rslave /usr/bin/dockerd-rootless.sh
                   ├─12257 /proc/self/exe --state-dir=/run/user/1000/dockerd-rootless --net=slirp4netns --mtu=65520 --slirp4netns-sandbox=auto --slirp4netns-seccomp=auto --disable-host-loopback --port-driver=builtin --copy-up=/etc --copy-up=/run --propagation=rslave /usr/bin/dockerd-rootless.sh
                   ├─12280 slirp4netns --mtu 65520 -r 3 --disable-host-loopback --enable-sandbox --enable-seccomp 12257 tap0
                   ├─12287 dockerd
                   └─12310 containerd --config /run/user/1000/docker/containerd/containerd.toml
      
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153014178+01:00" level=warning msg="WARNING: No io.weight support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153030585+01:00" level=warning msg="WARNING: No io.weight (per device) support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153046456+01:00" level=warning msg="WARNING: No io.max (rbps) support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153061641+01:00" level=warning msg="WARNING: No io.max (wbps) support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153076881+01:00" level=warning msg="WARNING: No io.max (riops) support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153092400+01:00" level=warning msg="WARNING: No io.max (wiops) support"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153143696+01:00" level=info msg="Docker daemon" commit=e63daec containerd-snapshotter=false storage-driver=overlay2 version=25.0.5
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.153462582+01:00" level=info msg="Daemon has completed initialization"
      Aug 08 15:06:05 pi64home dockerd-rootless.sh[12287]: time="2024-08-08T15:06:05.280678958+01:00" level=info msg="API listen on /run/user/1000/docker.sock"
      Aug 08 15:06:05 pi64home systemd[1118]: Started docker.service - Docker Application Container Engine (Rootless).
      + DOCKER_HOST=unix:///run/user/1000/docker.sock /usr/bin/docker version
      Client: Docker Engine - Community
       Version:           25.0.5
       API version:       1.44
       Go version:        go1.21.8
       Git commit:        5dc9bcc
       Built:             Tue Mar 19 15:05:26 2024
       OS/Arch:           linux/arm64
       Context:           default
      
      Server: Docker Engine - Community
       Engine:
        Version:          25.0.5
        API version:      1.44 (minimum version 1.24)
        Go version:       go1.21.8
        Git commit:       e63daec
        Built:            Tue Mar 19 15:05:26 2024
        OS/Arch:          linux/arm64
        Experimental:     false
       containerd:
        Version:          1.6.28
        GitCommit:        ae07eda36dd25f8a1b98dfbf587313b99c0190bb
       runc:
        Version:          1.1.12
        GitCommit:        v1.1.12-0-g51d5e94
       docker-init:
        Version:          0.19.0
        GitCommit:        de40ad0
       rootlesskit:
        Version:          2.0.2
        ApiVersion:       1.1.1
        NetworkDriver:    slirp4netns
        PortDriver:       builtin
        StateDir:         /run/user/1000/dockerd-rootless
       slirp4netns:
        Version:          1.2.0
        GitCommit:        656041d45cfca7a4176f6b7eed9e4fe6c11e8383
      + systemctl --user enable docker.service
      Created symlink /home/andrewcgaitskell/.config/systemd/user/default.target.wants/docker.service → /home/andrewcgaitskell/.config/systemd/user/docker.service.
      [INFO] Installed docker.service successfully.
      [INFO] To control docker.service, run: `systemctl --user (start|stop|restart) docker.service`
      [INFO] To run docker.service on system startup, run: `sudo loginctl enable-linger andrewcgaitskell`
      
      [INFO] Creating CLI context "rootless"
      Successfully created context "rootless"
      [INFO] Using CLI context "rootless"
      Current context is now "rootless"
      
      [INFO] Make sure the following environment variable(s) are set (or add them to ~/.bashrc):
      export PATH=/usr/bin:$PATH
      
      [INFO] Some applications may require the following environment variable too:
      export DOCKER_HOST=unix:///run/user/1000/docker.sock
