# turtlebot3 inside docker

## start x server (macOS)
```console
$IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
$xhost $IP
or
$/usr/X11/bin/xhost $IP
```

## run container
```console
$ docker run -ti --name turtlebot3 -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix thelurps/turtlebot3
```

## setup catkin workspace
```console
$ cd ~
$ mkdir catkin_ws
$ mkdir catkin_ws/src
$ cd catkin_ws
$ source /opt/ros/kinetic/setup.bash
$ catkin_make
```

## connect to container
```console
$ docker exec -ti turtlebot3 bash
```

## setup env
```console
$ source ~/catkin_ws/devel/setup.bash
$ export TURTLEBOT3_MODEL=burger
```

## launch gazebo
```console
$ roslaunch turtlebot3_gazebo turtlebot3_world.launch
```
