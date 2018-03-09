# turtlebot3 inside docker

## start x server (macOS)
```console
MBP:~ thelurps$ $IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
MBP:~ thelurps$ xhost + $IP
```

or

```console
MBP:~ thelurps$ /usr/X11/bin/xhost + $IP
```

## run container
```console
MBP:~ thelurps$ docker run -ti --name turtlebot3 -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix thelurps/turtlebot3
```

## setup catkin workspace
```console
MBP:~ thelurps$ cd ~
MBP:~ thelurps$ mkdir catkin_ws
MBP:~ thelurps$ mkdir catkin_ws/src
MBP:~ thelurps$ cd catkin_ws
MBP:~ thelurps$ source /opt/ros/kinetic/setup.bash
MBP:~ thelurps$ catkin_make
```

## connect to container
```console
MBP:~ thelurps$ docker exec -ti turtlebot3 bash
```

## setup env
```console
MBP:~ thelurps$ source ~/catkin_ws/devel/setup.bash
MBP:~ thelurps$ export TURTLEBOT3_MODEL=burger
```

## launch gazebo
```console
MBP:~ thelurps$ roslaunch turtlebot3_gazebo turtlebot3_world.launch
```
