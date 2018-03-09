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

# Error
```console
root@5ef068121c93:~/catkin_ws# roslaunch turtlebot3_gazebo turtlebot3_world.launch
... logging to /root/.ros/log/496ee852-23cd-11e8-ada1-0242ac110002/roslaunch-5ef068121c93-419.log
Checking log directory for disk usage. This may take awhile.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

xacro: Traditional processing is deprecated. Switch to --inorder processing!
To check for compatibility of your document, use option --check-order.
For more infos, see http://wiki.ros.org/xacro#Processing_Order
xacro.py is deprecated; please use xacro instead
started roslaunch server http://5ef068121c93:44737/

SUMMARY
========

PARAMETERS
 * /robot_description: <?xml version="1....
 * /rosdistro: kinetic
 * /rosversion: 1.12.12
 * /use_sim_time: True

NODES
  /
    camera_tf (tf/static_transform_publisher)
    gazebo (gazebo_ros/gzserver)
    gazebo_gui (gazebo_ros/gzclient)
    spawn_urdf (gazebo_ros/spawn_model)

ROS_MASTER_URI=http://localhost:11311

process[camera_tf-1]: started with pid [439]
process[gazebo-2]: started with pid [440]
process[gazebo_gui-3]: started with pid [462]
process[spawn_urdf-4]: started with pid [501]
[ INFO] [1520622767.970960683]: Finished loading Gazebo ROS API Plugin.
[ INFO] [1520622767.974839520]: waitForService: Service [/gazebo/set_physics_properties] has not been advertised, waiting...
No protocol specified
No protocol specified
No protocol specified
gazeb: cannot connect to X server 192.168.178.24:0
[gazebo_gui-3] process has died [pid 462, exit code 1, cmd /opt/ros/kinetic/lib/gazebo_ros/gzclient __name:=gazebo_gui __log:=/root/.ros/log/496ee852-23cd-11e8-ada1-0242ac110002/gazebo_gui-3.log].
log file: /root/.ros/log/496ee852-23cd-11e8-ada1-0242ac110002/gazebo_gui-3*.log
^C[spawn_urdf-4] killing on exit
[gazebo-2] killing on exit
[camera_tf-1] killing on exit
Traceback (most recent call last):
  File "/opt/ros/kinetic/lib/gazebo_ros/spawn_model", line 313, in <module>
    sm.callSpawnService()
  File "/opt/ros/kinetic/lib/gazebo_ros/spawn_model", line 271, in callSpawnService
    initial_pose, self.reference_frame, self.gazebo_namespace)
  File "/opt/ros/kinetic/lib/python2.7/dist-packages/gazebo_ros/gazebo_interface.py", line 28, in spawn_urdf_model_client
    rospy.wait_for_service(gazebo_namespace+'/spawn_urdf_model')
  File "/opt/ros/kinetic/lib/python2.7/dist-packages/rospy/impl/tcpros_service.py", line 159, in wait_for_service
    raise ROSInterruptException("rospy shutdown")
rospy.exceptions.ROSInterruptException: rospy shutdown
shutting down processing monitor...
... shutting down processing monitor complete
done
```
