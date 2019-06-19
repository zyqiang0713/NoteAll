## 最短路径规划
**1. Dijkstra算法**
各种算法[演示](http://www.webhek.com/post/pathfinding.html)

Dijkstra算法的[数学证明](https://blog.csdn.net/CrazyKeyboardMan/article/details/78219970)

讲解:
集合U表示当前所得到的点到原点距离, 集合S表示已经找到的最短距离.
在正权值的边中,起点开始,跟起点相连的边,距离更新到 集合U中,起点移入集合S;
假设此时集合U中的最短点为V1, 算出与V1相连的其他点,更新集合U,把V1移入集合S;
接着此时集合U中的最短点为V3,注意是所有点中的最短点(不是从V1延伸的最短点),更新V3点相连的边的点在集合U中, 把V3移入集合S;
重复上面的步骤.


