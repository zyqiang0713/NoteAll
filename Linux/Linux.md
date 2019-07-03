<b><details><summary> 关于 </summary></b>

1. strace 跟踪程序

</details>

<b><details><summary> Shell </summary></b>

</details>

<b><details><summary> Linux 编程 </summary></b>
  
## linux 进程间通信
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


</details>
