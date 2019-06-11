总结:https://www.nowcoder.com/discuss/124724?type=0&order=0&pos=20&page=0

#1.c++ 11 新特性
##(1) 
    nullptr 的引入, 区分空指针和 0.
##(2) 
    统一初始化语法
      struct A {
          int a;
          float b;
      };
      A a {1, 1.1};    // 统一的初始化语法
##(3)
    C++11 引入了委托构造的概念
        class Base {
    public:
        int value1;
        int value2;
        Base() {
            value1 = 1;
        }
        Base(int value) : Base() {  // 委托 Base() 构造函数
            value2 = 2;
        }
    };
    
    以及继承构造, 继承了A的所有不同类型的构造函数,而不用每个都定义一遍
    class B:A{
      using A::A;
      ........
     
##(4)
  新增容器
  std::array : 保存在栈内
  无序容器: 无序容器中的元素是不进行排序的，内部通过 Hash 表实现，插入和搜索元素的平均复杂度为 O(constant)。std::unordered_map/std::unordered_multimap 和 std::unordered_set/std::unordered_multiset。
  元组: std::tuple
  
##(5) 语言级线程支持

std::thread 
std::mutex/std::unique_lock 
std::future/std::packaged_task 
std::condition_variable

代码编译需要使用 -pthread 选项


##(6) 右值引用和move语义
    转移左值
    需要理解理解!!


#2. 
    static和const关键字的作用？

    static关键字的作用：

    （1）函数体内static变量的作用范围为该函数体，不同于auto变量，该变量的内存只被分配一次，因此其值在下次调用时仍维持上次的值；

    （2）在模块内的static全局变量可以被模块内所用函数访问，但不能被模块外其它函数访问；

    （3）在模块内的static函数只可被这一模块内的其它函数调用，这个函数的使用范围被限制在声明它的模块内；

    （4）在类中的static成员变量属于整个类所拥有，对类的所有对象只有一份拷贝；

    （5）在类中的static成员函数属于整个类所拥有，这个函数不接收this指针，因而只能访问类的static成员变量。

    const关键字的作用：

    （1）欲阻止一个变量被改变，可以使用const关键字。在定义该const变量时，通常需要对它进行初始化，因为以后就没有机会再去改变它了；

    （2）对指针来说，可以指定指针本身为const，也可以指定指针所指的数据为const，或二者同时指定为const；

    （3）在一个函数声明中，const可以修饰形参，表明它是一个输入参数，在函数内部不能改变其值；

    （4）对于类的成员函数，若指定其为const类型，则表明其是一个常函数，不能修改类的 成员变量；

    （5）对于类的成员函数，有时候必须指定其返回值为const类型，以使得其返回值不为“左值”。



#3. c++中的类或其他形式在内存中的分配情况



















