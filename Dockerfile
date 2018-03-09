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

# create non-root user
ENV USERNAME ros
ENV HOME /home/$USERNAME
USER $USERNAME

# create catkin_ws
RUN mkdir /home/$USERNAME/catkin_ws
WORKDIR /home/$USERNAME/catkin_ws
RUN mkdir /home/$USERNAME/catkin_ws/src
RUN echo 'source /opt/ros/kinetic/setup.bash' >> /home/$USERNAME/.bashrc
RUN source /opt/ros/kinetic/setup.bash
RUN catkin_make
RUN echo 'source /home/$USERNAME/catkin_ws/devel/setup.bash' >> /home/$USERNAME/.bashrc
RUN source /home/$USERNAME/catkin_ws/devel/setup.bash
