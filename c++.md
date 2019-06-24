<b><details><summary>💡 关于</summary></b>

📚 本仓库是面向 C/C++ 技术方向校招求职者、初学者的基础知识总结，包括语言、程序库、数据结构、算法、系统、网络、链接装载库等知识及面试经验、招聘、内推等信息。

📘 Summary 页面是目录收起，📖 Details 页面是全文展开，适用于不同场景和阅读习惯。

📄 保存为 PDF 方式：使用 Chrome 浏览器打开 <a href="https://github.com/huihut/interview/blob/master/README_Details.md">📖 Details</a> 页面，右键 - 打印 - 选择目标打印机是另存为PDF - 保存（[打印预览.png](images/打印预览.png)）

💡 右侧目录支持方式：[语雀的镜像仓库](https://www.yuque.com/huihut/interview/readme)、[Github + TOC 导航](https://github.com/jawil/GayHub)（[TOC预览.png](images/TOC预览.png)）

🙏 仓库内容如有错误或改进欢迎 issue 或 pr，建议或讨论可在 [#12](https://github.com/huihut/interview/issues/12) 提出。由于本人水平有限，仓库中的知识点有来自本人原创、读书笔记、书籍、博文等，非原创均已标明出处，如有遗漏，请 issue 提出。本仓库遵循 CC BY-NC-SA 4.0 协议，转载请注明出处。

</details>

<b><details><summary>💡 STL</summary></b>
## 1. STL中的map详解

C＋＋中有很多中[key-value](https://www.cnblogs.com/xiaoniu-666/p/9492967.html)形式的容器，map／hash_map／unordered_map／vector_map.

map使用红黑树实现.查找时间在O(lg(n))-O(2*log(n))之间，构建map花费的时间比较长，因而，map使用于那种插入和查询混合的情况。

hash_map，STL中的实现叫做**unordered_map**, hash_map的查找速度比map要快，因为hash_map的查找速度与数据量大小无关，属于常数级别。

</details>
