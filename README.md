# Moveit2 Tutorial 

## Running This Tutorial

First time users?
- Download docker [(More info here)](https://docs.docker.com/engine/install/ubuntu/)
- Clone Moveit2 Tutorial Repository [(Github link)](https://github.com/azalutsky/MoveIt2Docker)
```
>> git clone https://github.com/azalutsky/MoveIt2Docker.git
```
...or if you prefer to clone with ssh...
```
>> git clone git@github.com:azalutsky/MoveIt2Docker.git
```

- Build Docker image (This takes time, go grab a coffee/beer/...lunch)
```
>> sh ./build_docker.sh
```
- Run docker container 
```
>> ./run_docker.sh 
...
ROS2 sourced, sail away
root@anton-the-manton:~# 
```
If successful, you will see this splash screen stating `ROS2 sourced`. 

Now, visit here: [Moveit2 Tutorial](https://moveit.picknik.ai/foxy/doc/quickstart_in_rviz/quickstart_in_rviz_tutorial.html)
Lets do the first steps together...
```
>> ros2 launch moveit2_tutorials move_group.launch.py
```

in another terminal, go to the repository directory and run this (as seen in helpful docker commands)
```
./another_terminal.sh
```

This should allow you to run the other command: 
```
ros2 launch moveit2_tutorials move_group_interface_tutorial.launch.py
```

...and get started learning Moveit2! If you find something you did useful, add it here! 
Good luck! 
