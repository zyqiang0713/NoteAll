## Queen 和 Stack
Queen 是先进先出，利用这个特性进行算法开发， BFS典型应用
Stack 是先进后出。DFS典型应用

## BFS 广度优先算法
进行一级一级的查找，一级查找后，下一级元素入Queue，将上一级元素出Queue，一直循环，直到找到目标。此时的级数就是最短路径。

伪代码模板
'''
/**
 * Return the length of the shortest path between root and target node.
 */
int BFS(Node root, Node target) {
    Queue<Node> queue;  // store all nodes which are waiting to be processed
    int step = 0;       // number of steps neeeded from root to current node
    // initialize
    add root to queue;
    // BFS
    while (queue is not empty) {
        step = step + 1;
        // iterate the nodes which are already in the queue
        int size = queue.size();
        for (int i = 0; i < size; ++i) {
            Node cur = the first node in queue;
            return step if cur is target;
            for (Node next : the neighbors of cur) {
                add next to queue;
            }
            remove the first node from queue;
        }
    }
    return -1;          // there is no path from root to target
}
'''


## DFS 深度优先算法
假如进行迷宫寻迹，一条道走到黑，是在走不下去就 出栈， 然后换一条路，直到找到出路， 这时Stack中的数据就是出路，但不一定是最短的。



### 算法题
1. 岛屿数量
2. 打开转盘锁
3. 字符串解码
