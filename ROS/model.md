
1. Ros
运行cmd, 能够显示democar以及各个frame. rostopic可以看到有哪些topic
有jointstates topic, 通过发送 odom frame 与 base_link frame的tf, 可以通过rviz来得到小车的运动.
roslaunch urdf_tutorials display.launch model:=democar.urdf

2. xacro文件的解读:
https://blog.csdn.net/buaazyp/article/details/84815812
举下面例子,更多的看这个web

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
