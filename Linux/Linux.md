<b><details><summary> 关于 </summary></b>

1. strace 跟踪程序

</details>

<b><details><summary> Shell </summary></b>

## shell 编程
1. wc -l  : 统计文件的行数
  
2. awk  -Fxx  -n xx  '{print $1}'
  
3. sed  ' 22a  '"'this is a book '''   '   : sed中用单引号包裹双引号可以表示单引号输出
  
	Output: ‘this is a book ’
  
  awk  '{if(NF>2) {print  $3$1"@@"$2;} else {print $0;}}'   a.txt  : awk后列数大于2的进行前面， else 后面语句


</details>

<b><details><summary> Linux 编程 </summary></b>
  
## 1. linux 进程间通信
### 1.1 linux pipe的[详解](https://blog.csdn.net/bit_clearoff/article/details/55105816)

```
#include <unistd.h>
int     pipe(int fd[2]);
```  
由输出型参数fd返回两个文件描述符，fd[0]为读而打开，fd[1]为写而打开.

创建pipe
```
    int fd[2]={0,0};
    if(pipe(fd)!=0){
        //create false
        perror("pipe");
        exit(1);
    }
```

管道中写数据:
```
const char* msg="Hello,leap\n";
ssize_t size=write(fd[1],msg,strlen(msg));
```

管道中读数据
```
ssize_t Len=read(fd[0],buf,1024);
```

### 1.2 linux 信号处理

[参考这里](https://blog.csdn.net/bit_clearoff/article/details/56839751)

指定信号处理方式

- signum:参数为信号名，或者信号编号。
- handler:为指向返回值为void参数为int的函数指针，或者是SIG_IGN或SIG_DFL宏定义。
```
       #include <signal.h>
       typedef void (*sighandler_t)(int);
       sighandler_t signal(int signum, sighandler_t handler);
```

alarm函数相当于一个闹钟， alarm(5)注册了一个5s的闹钟， 5s中后会产生**SIGALRM**到本进程。
```
       #include <unistd.h>
       unsigned int alarm(unsigned int seconds);
```

![信号](https://github.com/zyqiang0713/NoteAll/blob/master/Linux/png/signal.png)

***signal 与 sigaction ***的[区别](https://blog.csdn.net/wangzuxi/article/details/44814825)
推荐用sigaction()

### 1.3 linux 信号量 Semaphore Mutex

```
sem_t       //信号量类型
sem_init(sem_t *sem, int pshared, unsigned int value);
sem_wait(sem_t *sem)
sem_trywait
sem_timedwait
sem_post(sem_t *sem)
sem_destroy
```

初始状态不一样：mutex的初始值是1（表示锁available），而semaphore的初始值是0，这个初始值可以初始化的时候设置（表示unsignaled的状态）

### 1.4 LINUX  socket 编程

在使用socket创建套接字时通过指定参数domain是af_inet（ipv4因特网域）或af_inet6（ipv6因特网域）或af_unix（unix域）来实现。

几个重要的[函数](https://blog.csdn.net/shallnet/article/details/17734919)：

有自旋锁 和 信号量 的选择：

自旋锁： spin_lock, spin_unlock

如果需要在自旋锁和信号量中做出选择，应该根据锁被持有的时间长短做判断，如果加锁时间不长并且代码不会休眠，利用自旋锁是最佳选择。相反，如果加锁时间可能很长或者代码在持有锁有可能睡眠，那么最好使用信号量来完成加锁功能。信号量一个有用特性就是它可以同时允许任意数量的锁持有者，而自旋锁在一个时刻最多允许一个任务持有它。信号量同时允许的持有者数量可以在声明信号量时指定，当为1时，成为互斥信号量，否则成为计数信号量


**1. socket() 函数：**

参数指明了协议族，它的值通常为：AF_INET(IPv4协议）、AF_INET6(IPv6协议)、AF_ROUTE(路由套接口)、AF_LOCAL(UNIX域协议)、AF_KEY(密钥套接字)。type参数指明产生套接字的类型，它的值通常为：SOCK_STREAM(TCP使用这种形式)、SOCK_DGRAM(UDP使用这种形式)、SOCK_RAW(原始套接口）。protocol参数是协议标志，一般在调用socket()函数时将其置为0。
```
　　#include<sys/socket.h>
　　int socket(int family, int type, int protocol);
```
**2. bind() 函数** 

绑定函数的作用是为调用socket()函数产生的套接字分配一个本地协议地址，建立地址与套接字的对应关系。注意：协议地址addr是通用地址。sockfd参数是之前调用socket()函数返回的套接字描述符。server参数为一个结构体，其中包含了服务器端的地址信息。因此，必须在调用bind()函数之前，初始化该结构体，指定服务器端绑定的端口号以及IP地址。
```
#include<sys/socket.h>
　　int bind(int sockfd, const struct sockaddr *seraddr, socklen_len addrlen);
```

**3. listen()函数** 

该函数比较简单，调用listen()函数后，将未连接的套接字转换成被动套接字，使它处在监听模式下，服务器的状态从CLOSED转换到了LISTEN状态
```
　　#include<sys/socket.h>
　　int listen(int sockfd, int backlog);
```

**4. accept()函数:** 

accept()函数使服务器接受客户端的连接请求。该函数最多返回三个值：一个既可能是新套接字也可能是错误指示的整数，一个客户进程的协议地址（由client所指），以及该地址的大小（这后两个参数是值－结果参数）；也就是说，服务器可以通过参数client来得到请求连接并获得成功的客户的地址和端口号。在实际使用中，如果服务器端并不想保存客户的地址和端口号，也可以使用accept(listenfd, NULL, NULL)。　　　　
至此，服务器与客户端的连接便建立了，接下来便是数据的发送和接收。发送和接收数据可以使用write(),read()/send(),recv()函数。

```
　　#include<sys/socket.h>
　　int accept(int listenfd, struct sockaddr *client, socklen_t *addr_len)
```

**5. connect函数：**

客户端使用该函数来与服务器建立连接，第二个参数套接字地址必须包含服务器的IP地址和端口号，客户端在调用该函数前不一定要调用bind函数，内核会确定源IP，并且选定一个临时端口作为源端口。

```
#include <sys/socket.h> 
int connect( int sockfd, const struct sockaddr *seraddr, socklen_t     addrlen);
```

**6. send()函数：**

参数sockfd为套接字描述符，参数buf指向一个用于发送信息的数据缓冲区，len指明传送数据缓冲区的大小。参数flags是传输控制标志，当值为0时，函数所作的操作与write()相同。
```
　　#include<sys/types.h>
　　#include<sys/socket.h>
　　ssize_t send(int sockfd, const void *buf, size_t len, int flags);
```

**7.recv()函数：**

```
　　#include<sys/types.h>
　　#include<sys/socket.h>
　　ssize_t recv(int sockfd, void *buf, size_t len, int flags);
```


**并发服务器程序轮廓**

为了server能够很多同时到来的 客户端请求， 需要fork处进程
```
pid_t pid;
int listenfd,connfd;
listenfd = socket( ... );
bind(listen, ... );
listen(listenfd,LISTENQ);
for(;;)
{
connfd = accept(listenfd, ... );
if((pid = fork()) == 0)
{
close(listenfd);
doit(connfd);
close(connfd);
exit(0);
}
close(connfd);
}
```

## 2. linux 的内存分配

### 1. 内存管理

几篇有助于理解的文章：

Linux内存管理[原理](https://yq.aliyun.com/articles/369236?spm=a2c4e.11153940.0.0.4f6f7d96Qrdoe2)

![内存](https://github.com/zyqiang0713/NoteAll/blob/master/Linux/png/MM.png)

内存 进程 [管理](https://blog.csdn.net/shallnet/article/details/47701225)

内存[虚拟地址](https://blog.csdn.net/m0_37760347/article/details/81155553)

内存管理[图片](https://blog.csdn.net/unix21/article/details/8450186)

采用"伙伴"关系来管理内存空闲页面。

linux[内存管理](https://blog.csdn.net/hustyangju/article/details/46330259)

在32位系统中，地址空间是4G，其中内核规定3~4G的范围是内核空间，0~3G是用户空间（每个用户进程都有这么大的虚拟空间）（图：中下）。前面提到过内核的地址映射是写死的，就是指这3~4G的对应的页表是写死的，它映射到了物理地址的0~1G上。（实际上没有映射1G，只映射了896M。剩下的空间留下来映射大于1G的物理地址，而这一部分显然不是写死的）。所以，大于896M的物理地址是没有写死的页表来对应的，内核不能直接访问它们（必须要建立映射），称它们为高端内存（当然，如果机器内存不足896M，就不存在高端内存。如果是64位机器，也不存在高端内存，因为地址空间很大很大，属于内核的空间也不止1G了）；

## 3. linux 调试工具

gdb： 可以先看看gdb[介绍](https://blog.csdn.net/gatieme/article/details/51671430).

strace ： 用来跟踪程序执行时的系统调用和所接收的信号。 还可以统计程序执行时的关于系统调用和接收的各种信息。

学习下strace[教程](https://www.linuxidc.com/Linux/2015-10/124338.htm)

</details>
