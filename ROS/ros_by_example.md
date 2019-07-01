<b><details><summary> 基本操作 </summary></b>

### ros中的基本操作和module

roscore 启动ros的核心进程, ros后序启动的各个进程,topic等需要在这里注册.
  
</details>


<b><details><summary> 第八章 </summary></b>
  
### 1. 几个要用到的module
In this chapter, we will cover the three essential ROS packages that make up the core of
the Navigation Stack:

[move_base](http://wiki.ros.org/move_base) for moving the robot to a goal pose within a given reference frame

[gmapping](http://wiki.ros.org/gmapping) for creating a map from laser scan data (or simulated laser data from a depth camera)

[amcl](http://wiki.ros.org/amcl) for **localization using an existing map**


### 2.Navigitation, Path Planing and SLAM
1. move_base有以下四个配置文件,配置后才能正常使用move_base。
看一下配置的内容.
• base_local_planner_params.yaml
• costmap_common_params.yaml
• global_costmap_params.yaml
• local_costmap_params.yaml
测试空地图下在arbotix仿真器的运行, 在rbx1_nav目录下有**blank_map.pgm 空地图**

运行空地图测试:
roslaunch rbx1_bringup fake_turtlebot.launch
roslaunch rbx1_nav fake_move_base_blank_map.launch
rosrun rviz rviz -d `rospack find rbx1_nav`/nav.rviz
发布命令是:
**rostopic pub /move_base_simple/goal geometry_msgs/PoseStamped \
'{ header: { frame_id: "map" }, pose: { position: { x: 1.0, y: 0, z:
0 }, orientation: { x: 0, y: 0, z: 0, w: 1 } } }'**
发布到topic  /move_base_simple/goal.

#### avoid obstocles

roslaunch rbx1_nav fake_move_base_map_with_obstacles.launch
rosrun rviz rviz -d `rospack find rbx1_nav`/nav_obstacles.rviz

多了nav_obstacles_params.yaml,看看obstocal怎么造出来的.

### 3. map building with gmapping package
slam_gmapping用来combine laser数据和odometry成一个map.
是有道理的,靠laser来扫描障碍和距离, odometry可以估算出机器人走的路线,角度距离等,可以构建出一个map.
The ROS gmapping package contains the slam_gmapping node that does the work of combining the data from laser scans and odometry into an occupancy map


关于sensor_msgs/LaserScan的内容如[网页](https://www.jianshu.com/p/1e3ddc43a949)


***记录数据***
rosbag record -O my_scan_data /scan /tf 
命令记录的是scan 和 tf, tf是/odom 和 /base_link的transform


***创建地图***
rosrun map_server map_saver -f my_map
可以输出 **my_map.pgm**

### 4. Navigation and Localization using a Map and amcl
ROS uses the [amcl](http://wiki.ros.org/amcl) package to localize the robot within an existing map using the
current scan data coming from the robot's laser or depth camera.

```
$ roslaunch rbx1_bringup fake_turtlebot.launch
$ roslaunch rbx1_nav fake_amcl.launch map:=test_map.yaml
rosrun rviz rviz -d `rospack find rbx1_nav`/amcl.rviz
```
运行后如图 ![所示](https://github.com/zyqiang0713/NoteAll/blob/master/ROS/png/acml.png)

需要看一下地图 test_map.yaml


</details>



<b><details><summary> 第十章 Robot Vision </summary></b>

The three pillars of computer vision in the ROS community are **[OpenCV](https://opencv.org/), OpenNI2 + OpenKinect, and PCL**. 

The default camera launch files distributed with ROS use a 640x480 resolution. If you
need lower or higher resolution, you can use rqt_reconfigure or the camera's launch
file to change resolution modes as we will illustrate below.

### 10.4. Installing OpenCV on Ubuntu Linux

```
$ sudo apt-get install ros-indigo-vision-opencv libopencv-dev \
python-opencv
$ rospack profile
```

to check installation
```
$ python
>>> from cv2 import cv
>>> quit()
```

### 10.5 ROS的[cv_bridge](http://wiki.ros.org/cv_bridge)

用cv_bridge来转换OPENCV和ROS之间的图片格式。

</details>

