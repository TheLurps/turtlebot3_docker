FROM ros:kinetic-robot-xenial

MAINTAINER Joshua Schraven

RUN apt-get update && apt-get install --assume-yes \
  ros-kinetic-turtlebot3 \
  ros-kinetic-turtlebot3-bringup \
  ros-kinetic-turtlebot3-description \
  ros-kinetic-turtlebot3-fake \
  ros-kinetic-turtlebot3-gazebo \
  ros-kinetic-turtlebot3-msgs \
  ros-kinetic-turtlebot3-navigation \
  ros-kinetic-turtlebot3-simulations \
  ros-kinetic-turtlebot3-slam \
  ros-kinetic-turtlebot3-teleop
