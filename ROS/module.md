<b><details><summary>💡 ROS中不同的module</summary></b>

📘 Summary 页面是目录收起，📖 Details 页面是全文展开，适用于不同场景和阅读习惯。

📄 保存为 PDF 方式：使用 Chrome 浏览器打开 <a href="https://github.com/huihut/interview/blob/master/README_Details.md">📖 Details</a> 页面，右键 - 打印 - 选择目标打印机是另存为PDF - 保存（[打印预览.png](images/打印预览.png)）

</details>

<b><details><summary> move_base </summary></b>

在ros wiki中可以找到[网页](http://wiki.ros.org/move_base)


</details>

<b><details><summary> gmapping module </summary></b>

在ros wiki中可以找到[网页](http://wiki.ros.org/gmapping)
The slam_gmapping node takes in ***sensor_msgs/LaserScan*** messages and builds a map (***nav_msgs/OccupancyGrid***).
The map can be retrieved via a ROS topic or service. 
需要subscribe tf/tfMessages 和 sensor_msgs/LaserScan, 通过laser的数据生成一个map 并publish,其他node可以订阅这个topic.
slam_mapping可以设置很多的参数,具体看ros wiki.

</details>

<b><details><summary> tf </summary></b>

在ros wiki中可以找到[网页](http://wiki.ros.org/tf)


</details>


<b><details><summary> amcl for localization using an existing map </summary></b>
在ros wiki中可以找到[网页](http://wiki.ros.org/acml)

</details>

<b><details><summary> actionlib  </summary></b>
  
在ros wiki中可以找到[网页](http://wiki.ros.org/actionlib)

作为例子:在ros/indigo/include/actionlib_tutorials/FibonacciFeedback.h中, 看以下action具体生成的容器写法及用法.

</details>



<b><details><summary> costmap_2d  </summary></b>
在ros wiki中可以找到[网页](http://wiki.ros.org/costmap_2d#Parameters)

</details>

<b><details><summary> 欧拉角 四元数 的表示方法 </summary></b>
可以参考[这个](https://www.matongxue.com/madocs/442.html)
  
要表示Quaternion 的方法（w, x, y, z）

欧拉旋转会发生[万向节锁](https://blog.csdn.net/AndrewFan/article/details/60981437#)
  
</details>
