# start x server (macOS)
```console
MBP:~ thelurps$ export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
MBP:~ thelurps$ /usr/X11/bin/xhost + $IP
MBP:~ thelurps$ open -a XQuartz
```

# run container
```console
MBP:~ thelurps$ $CATKIN_WS='~/catkin_ws'
MBP:~ thelurps$ docker run -ti --name turtlebot3 -e DISPLAY=$IP:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v $CATKIN_WS:/root/catkin_ws/src thelurps/turtlebot3
```

# setup catkin workspace
```console
ros@turtlebot3:~/catkin_ws$ mkdir src
ros@turtlebot3:~/catkin_ws$ catkin_make
ros@turtlebot3:~/catkin_ws$ source devel/setup.bash
```

# connect to container
```console
MBP:~ thelurps$ docker exec -ti turtlebot3 bash
```

# setup env
```console
ros@turtlebot3:~/catkin_ws$ source ~/catkin_ws/devel/setup.bash
ros@turtlebot3:~/catkin_ws$ export TURTLEBOT3_MODEL=waffle
```

# launch gazebo
```console
ros@turtlebot3:~/catkin_ws$ roslaunch turtlebot3_gazebo turtlebot3_world.launch
```
