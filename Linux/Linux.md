<b><details><summary> 关于 </summary></b>

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

</details>
