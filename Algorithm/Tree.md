## 二叉树的遍历
1.前序遍历: 先访问根节点,然后左节点,最后右节点
2.中序遍历: 先访问左节点,然后根节点,最后右节点
3.后序遍历: 先访问左节点,然后右节点,最后根节点

## 解决方法
### 1.自顶向下 伪代码

1. return specific value for null node
2. update the answer if needed                      // anwer <-- params
3. left_ans = top_down(root.left, left_params)      // left_params <-- root.val, params
4. right_ans = top_down(root.right, right_params)   // right_params <-- root.val, params
5. return the answer if needed                      // answer <-- left_ans, right_ans

### 2.自下而上

1. return specific value for null node
2. left_ans = bottom_up(root.left)          // call function recursively for left child
3. right_ans = bottom_up(root.right)        // call function recursively for right child
4. return answers                           // answer <-- left_ans, right_ans, root.val

### Difference
看起来一个递归函数有参数, 一个没有参数但是有返回值. 两种设计思路不一样


###  分析
当遇到树问题时，请先思考一下两个问题：

    你能确定一些参数，从该节点自身解决出发寻找答案吗？
    你可以使用这些参数和节点本身的值来决定什么应该是传递给它子节点的参数吗？

如果答案都是肯定的，那么请尝试使用 “自顶向下” 的递归来解决此问题。

或者你可以这样思考：对于树中的任意一个节点，如果你知道它子节点的答案，你能计算出该节点的答案吗？ 如果答案是肯定的，那么 “自底向上” 的递归可能是一个不错的解决方法。

### 习题
1.对称二叉树
2.路径总和
3.中序遍历和后序遍历构造二叉树
4.填充每个节点的下一个右侧节点指针
