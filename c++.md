<b><details><summary>💡 关于</summary></b>

📚 本仓库是面向 C/C++ 技术方向校招求职者、初学者的基础知识总结，包括语言、程序库、数据结构、算法、系统、网络、链接装载库等知识及面试经验、招聘、内推等信息。

📘 Summary 页面是目录收起，📖 Details 页面是全文展开，适用于不同场景和阅读习惯。

📄 保存为 PDF 方式：使用 Chrome 浏览器打开 <a href="https://github.com/huihut/interview/blob/master/README_Details.md">📖 Details</a> 页面，右键 - 打印 - 选择目标打印机是另存为PDF - 保存（[打印预览.png](images/打印预览.png)）

💡 右侧目录支持方式：[语雀的镜像仓库](https://www.yuque.com/huihut/interview/readme)、[Github + TOC 导航](https://github.com/jawil/GayHub)（[TOC预览.png](images/TOC预览.png)）

🙏 仓库内容如有错误或改进欢迎 issue 或 pr，建议或讨论可在 [#12](https://github.com/huihut/interview/issues/12) 提出。由于本人水平有限，仓库中的知识点有来自本人原创、读书笔记、书籍、博文等，非原创均已标明出处，如有遗漏，请 issue 提出。本仓库遵循 CC BY-NC-SA 4.0 协议，转载请注明出处。

</details>

<b><details><summary>C++ 概念</summary></b>

## 1. c++ template

template的[定义讲解](https://blog.csdn.net/lezardfu/article/details/56852043)

## 2. 友元

友元提供了一种 普通函数或者类成员函数 访问另一个类中的私有或保护成员 的机制。

[友元函数](http://c.biancheng.net/view/2233.html)不能直接访问类的成员，必须借助对象。友元函数是非成员函数，不属于某个类的。

## 3.贪心算法  动态规划

贪心和动态规划 两个算法 的[概念与区别](https://www.zhihu.com/question/32096465)

</details>

<b><details><summary>C++ 语法</summary></b>
### 1. 运算符重载

重载 + 号运算符， 返归的类型为 Box， 参数为两个Box 类型的变量。

Box operator+(const Box&, const Box&);

### 2. c++模板的语法

[类模板](http://c.biancheng.net/view/2318.html)创建对象，类模板中的函数书写规范是什么，也是需要有一个模板头。


### 3. 拷贝构造函数的构造

Student(const Student &stu);  //拷贝构造函数（声明）

 1) 为什么必须是当前类的引用呢？
如果拷贝构造函数的参数不是当前类的引用，而是当前类的对象，那么在调用拷贝构造函数时，会将另外一个对象直接传递给形参，这本身就是一次拷贝，会再次调用拷贝构造函数，然后又将一个对象直接传递给了形参，将继续调用拷贝构造函数……这个过程会一直持续下去，没有尽头，陷入死循环。

只有当参数是当前类的引用时，才不会导致再次调用拷贝构造函数，这不仅是逻辑上的要求，也是 C++ 语法的要求。

 2) 为什么是 const 引用呢？
拷贝构造函数的目的是用其它对象的数据来初始化当前对象，并没有期望更改其它对象的数据，添加 const 限制后，这个含义更加明确了。

另外一个原因是，添加 const 限制后，可以将 const 对象和非 const 对象传递给形参了，因为非 const 类型可以转换为 const 类型。如果没有 const 限制，就不能将 const 对象传递给形参，因为 const 类型不能转换为非 const 类型，这就意味着，不能使用 const 对象来初始化当前对象了。


### 4. 继承与派生的注意关系

public，protect, private 继承，所产生的效果不同。

如果希望基类的成员能够被派生类继承并且毫无障碍地使用，那么这些成员只能声明为 public 或 protected；只有那些不希望在派生类中使用的成员才声明为 private。只能借助基类的public的成员函数来访问基类中private的成员。

可以使用using改变成员的访问权限。

//People(name, age)就是调用基类的构造函数


Student::Student(char *name, int age, float score): People(name, age), m_score(score){ }

关于调用基类的构造函数。

派生类调用构造函数时，没有指定基类的构造函数，则会调用基类不带参数的默认构造函数，若没有默认构造函数，则编译会报错。

***虚继承***为了解决多继承时的命名冲突和冗余数据问题。***菱形继承***。

	
</details>

<b><details><summary>💡 STL</summary></b>
## 1. STL中的map详解

C＋＋中有很多中[key-value](https://www.cnblogs.com/xiaoniu-666/p/9492967.html)形式的容器，map／hash_map／unordered_map／vector_map.

map使用红黑树实现.查找时间在O(lg(n))-O(2*log(n))之间，构建map花费的时间比较长，因而，map使用于那种插入和查询混合的情况。

hash_map，STL中的实现叫做**unordered_map**, hash_map的查找速度比map要快，因为hash_map的查找速度与数据量大小无关，属于常数级别。

std::unordered_map 就是以key来查找value而设计,不会根据key排序。

std::unordered_set 是基于hash表的，因此并不是顺序存储。

std::map 就是以key来查找value而设计，**根据key排序**。

std::set 是基于红黑树的内部需要进行排序，自动调整红黑树保持平衡，set用于快速查找，不可修改键值。

**map和set都是以节点的形式保存，插入和删除速度快，不需要内存移动和copy。**

***unorder_map 插入数据的方式***
```
	// 插入数据的三种方式
	dict.insert(pair<string,int>("apple",2));
	dict.insert(unordered_map<string, int>::value_type("orange",3));
	dict["banana"] = 6;
```
## 2. set用法， unordered_set
***set：基于红黑树，自动排序功能， 内部是有序的。***

***unordered_set： 基于hash表， 插入和查找时间复杂度低，但需要消耗内存***

1.元素插入：insert()

2.中序遍历：类似vector遍历（用迭代器）

3.反向遍历：利用反向迭代器reverse_iterator。
```
    set<int> s;
    ......
    set<int>::reverse_iterator rit;
    for(rit=s.rbegin();rit!=s.rend();rit++)
```

4.元素删除：与插入一样，可以高效的删除，并自动调整使红黑树平衡。

            set<int> s;
            
            s.erase(2);        //删除键值为2的元素
            
            s.clear();
            
5.元素检索：find()，若找到，返回该键值迭代器的位置，否则，返回最后一个元素后面一个位置。

```
            set<int> s;
            set<int>::iterator it;
            it=s.find(5);    //查找键值为5的元素
            if(it!=s.end())    //找到
                cout<<*it<<endl;
            else            //未找到
                cout<<"未找到";
```

**6.自定义比较函数**

**7.解题**
（1）set来解决两个数组的交集
（2）快乐数


</details>
