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
```console
host:~ user$ docker container ls -a
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS                     PORTS               NAMES
bd19d5c576d5        jess/firefox        "/usr/bin/firefox"   15 seconds ago      Exited (0) 5 seconds ago                       firefox
host:~ user$ docker container rm bd19d5c576d5
bd19d5c576d5
host:~ user$ xhost + 127.0.0.1
127.0.0.1 being added to access control list
host:~ user$ docker run -d --name firefox -e DISPLAY=127.0.0.1:0 -v /tmp/.X11-unix:/tmp/.X11-unix jess/firefox
85c3d56f2a82aac17f849e473b01486c28a2719d301b401ef32772c8eaa8c6d1
```

## Error
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
