
# 1. Ros
运行cmd, 能够显示democar以及各个frame. rostopic可以看到有哪些topic
有jointstates topic, 通过发送 odom frame 与 base_link frame的tf, 可以通过rviz来得到小车的运动.
roslaunch urdf_tutorials display.launch model:=democar.urdf

# 2. xacro文件的解读:
**举下面例子,更多的看这个[web](https://blog.csdn.net/buaazyp/article/details/84815812)**
例如: tricycle.xacro
<?xml version="1.0"?>                         : 代表使用的xml版本是1.0
   机器人的名字叫做"tricycle"，其使用的格式为在"http://www.ros.org/wiki/xacro"中定义的xacro格式
<robot xmlns:xacro="http://www.ros.org/wiki/xacro" name="tricycle" >  
 
  导入文件,文件是 gazebo_plugins包内/test/tricycle_drive/xacro文件夹下的materials.xacro文件
  <!-- Import Rviz colors -->
  <xacro:include filename="$(find gazebo_plugins)/test/tricycle_drive/xacro/materials.xacro" />
 
 下面表示，载入的文件是 gazebo_plugins包内/test/tricycle_drive/xacro/tricycle文件夹下的tricycle_body.xacro文件
  <!-- Import robot  -->
  <xacro:include filename="$(find gazebo_plugins)/test/tricycle_drive/xacro/tricycle/tricycle_body.xacro"/>
  
  表示，tricycle_body的父环节是base_link，使用的碰撞网格文件是package://gazebo_plugins/test/tricycle_drive/meshes/tricycle
  <xacro:tricycle_body parent="base_link" meshes="package://gazebo_plugins/test/tricycle_drive/meshes/tricycle"/>
</robot>


# 3.arbotix的作用 
arbotix 仿真的作用是将 cmd_vel 的命令,转换成控制机器人的命令, 如joint该怎么动, 看仿真后会发出 joint_state 以及 tf, odom坐标等信息.
这些信息都可以被rviz subscribed 后显示出来.
下面的node 是arbotix, yaml是设置的参数吗?需要研究一下
<node name="arbotix" pkg="arbotix_python" type="arbotix_driver" output="screen" clear_params="true">
      <rosparam file="$(find rbx1_bringup)/config/fake_turtlebot_arbotix.yaml" command="load" />
      <param name="sim" value="true"/>
  </node>

# 4. Navigation, path planing and SLAM
 **move_base** for moving the robot to a goal pose within a given reference frame
 **gmapping** for creating a map from laser scan data (or simulated laser data from a depth camera)
 **amcl** for localization using an existing map
 ## 1) [move_base](http://wiki.ros.org/move_base)
![move_base](https://github.com/zyqiang0713/NoteAll/blob/master/ROS/png/navigation_overview.png)
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
