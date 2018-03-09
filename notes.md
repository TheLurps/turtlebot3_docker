# some notes about passing through x server on macOS

## works
```console
host:~ user$ open -a XQuartz
host:~ user$ IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
host:~ user$ xhost + $IP
192.168.178.24 being added to access control list
host:~ user$ docker run -d --name firefox -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix jess/firefox
1e3b7076f345c8cb6843ec38b3ab442905bb0b883d25856d75e4b786303b9487
```

## works again
```console
host:~ user$ docker container ls -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
1e3b7076f345        jess/firefox        "/usr/bin/firefox"   34 seconds ago      Exited (0) 8 seconds ago                       firefox
host:~ user$ docker rm 1e3b7076f345
1e3b7076f345
host:~ user$ docker run -d --name firefox -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix jess/firefox
bd19d5c576d55bf3a2ee409b67277acaf4cf90dc14957034445c424a828812d4
```

## doesn't work
host:~ user$ docker container ls -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
bd19d5c576d5        jess/firefox        "/usr/bin/firefox"   15 seconds ago      Exited (0) 5 seconds ago                       firefox
host:~ user$ docker container rm bd19d5c576d5
bd19d5c576d5
host:~ user$ xhost + 127.0.0.1
127.0.0.1 being added to access control list
host:~ user$ docker run -d --name firefox -e DISPLAY=127.0.0.1:0 -v /tmp/.X11-unix:/tmp/.X11-unix jess/firefox
85c3d56f2a82aac17f849e473b01486c28a2719d301b401ef32772c8eaa8c6d1
