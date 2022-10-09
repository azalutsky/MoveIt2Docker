# Moveit2 Tutorial 


## Things You Need

- Ubuntu (unsure of which version is recommended)
- Download docker [(More info here)](https://docs.docker.com/engine/install/ubuntu/)

## Running This Tutorial

First time users?
- Clone Moveit2 Tutorial Repository [(Github link)](https://github.com/azalutsky/MoveIt2Docker)
```
>> git clone https://github.com/azalutsky/MoveIt2Docker.git
```
...or if you prefer to clone with ssh...
```
>> git clone git@github.com:azalutsky/MoveIt2Docker.git
```

- Build Docker image (This takes time, 10-20 minutes (sorry...), go grab a coffee/beer/...lunch)
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
>> ros2 launch moveit2_tutorials demo.launch.py rviz_tutorial:=true
```

...and get started learning Moveit2! If you find something you did useful, add it here! 
Good luck! 
