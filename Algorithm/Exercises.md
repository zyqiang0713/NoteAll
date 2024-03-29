## 最短路径规划
***1. Dijkstra算法***

各种算法[演示](http://www.webhek.com/post/pathfinding.html)

Dijkstra算法的[数学证明](https://blog.csdn.net/CrazyKeyboardMan/article/details/78219970)

讲解:
集合U表示当前所得到的点到原点距离, 集合S表示已经找到的最短距离.

在正权值的边中,起点开始,跟起点相连的边,距离更新到 集合U中,起点移入集合S;

假设此时集合U中的最短点为V1, 算出与V1相连的其他点,更新集合U,把V1移入集合S;

接着此时集合U中的最短点为V3,注意是所有点中的最短点(不是从V1延伸的最短点),更新V3点相连的边的点在集合U中, 把V3移入集合S;

重复上面的步骤.

***2. Floyd 算法***
算法[介绍](https://zhuanlan.zhihu.com/p/33162490)

```
 private void floyd() {
        for (int k = 0; k < n; k++) {
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    a[i][j] = Math.min(a[i][j], a[i][k] + a[k][j]);
                }
            }
        }
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                System.out.println(i + " " + j + ":" + a[i][j]);
            }
        }
    }
```

上面就是Floyd算法， 但并没有记录下最短路径，**求具体路径**

我们上面仅仅是知道了最短路径的长度，实际应用中我们常常是需要知道具体的路径，在Floyd算法中怎么求具体路径呢，很简单，我们只需要记录下来在更新f[i][j]的时候，用到的中间节点是哪个就可以了。假设我们用path[i][j]记录从i到j松弛的节点k，那么从i到j,肯定是先从i到k，然后再从k到j， 那么我们在找出path[i][k] , path[k][j]即可，即 i到k的最短路是 i -> path[i][k] -> k -> path[k][j] -> k 然后求path[i][k]和path[k][j] ，一直到某两个节点没有中间节点为止，代码如下：

在更新路径的时候：
```
if(a[i][k]>temp){
    a[i][j] = temp;
    path[i][j] = k;
}
```
**总结：**

Floyd算法只能在不存在负权环的情况下使用，因为其并不能判断负权环，上面也说过，如果有负权环，那么最短路将无意义，因为我们可以不断走负权环，这样最短路径值便成为了负无穷。但是其可以处理带负权边但是无负权环的情况。以上就是求多源最短路的Floyd算法，基于动态规划，十分优雅。但是其复杂度确实是不敢恭维，因为要维护一个路径矩阵，因此空间复杂度达到了O(n^2)，时间复杂度达到了O(n^3)，只有在数据规模很小的时候，才适合使用这个算法，但是在实际的应用中，求单源最短路是最常见的，比如在路由算法中，某个节点仅需要知道从这个节点出发到达其他节点的最短路径，而不需要知道其他点的情况，因此在路由算法中最适合的应该是单源最短路算法，Dijkstra算法。


***3. A* 算法***
1. 
参考内容[1](https://blog.csdn.net/hitwhylz/article/details/23089415)    [2]()

看一下这篇[论文](https://blog.csdn.net/coutamg/article/details/53923717)

[简单解释](https://www.cnblogs.com/21207-iHome/p/6048969.html)

A* 在Dijkstra算法的基础上, 加入当前点距离 起点和终点的和的最短距离,而不是之前只看到起点的距离. 这里到终点的距离简化使用了曼哈顿距离 测算.


***4. RRT 算法***

参考[这个](https://www.cnblogs.com/21207-iHome/p/7210543.html)

与ROS相关的RRT算法[介绍](https://blog.csdn.net/zhangrelay/article/details/76850690)


## 递归算法

查看爬楼梯问题的不同解决方法











