## Hash design
***1.*** 根据key值算出哈希值,通过哈希值去快速查表得到对应的value,以空间换时间.
***2.*** 设计hash代码 c++:
```
class MyHashSet { private: vector<vector<int>> buckets; //所有的桶构成二维变长数组 
  const int bucketNums = 1000; //桶的个数 
  const int bucketSize = 1000; //桶的大小，可容纳的最多的数字的个数 
  public: /** Initialize your data structure here. */ 
  MyHashSet() { 
      buckets.resize(bucketNums); 
    } 
  bool isInBucket(int index, int key){ //查询在index号桶中，是否存在key 
    for(auto i : buckets[index])
    { 
      if(i == key)
        { 
        return true; 
        } 
    } 
        return false; 
  } 
  void add(int key) { 
    int index = key % bucketSize;
    if(isInBucket(index, key) == false){ 
      buckets[index].push_back(key); 
    } 
  } 
  void remove(int key) {
    int index = key % bucketSize; 
    if(isInBucket(index, key) == true)
    {
      int i = 0; 
      while(buckets[index].at(i) != key)
      {
         i++; 
      } 
      buckets[index].erase(buckets[index].begin()+i); 
    } 
  } 
  /** Returns true if this set contains the specified element */ 
  bool contains(int key) 
  { 
    return isInBucket(key%bucketSize, key); 
  } 
};
```


## hash的设计难点是在键的设计
1.字母异位词分组.  [解法](https://www.cnblogs.com/ariel-dreamland/p/9143262.html)

## c++中哈希表
**unordered_map<const Key, T> map;**
unordered_map的迭代器是一个指针，指向这个元素，通过迭代器来取得它的值。

***hash中的迭代器***
unordered_map<Key,T>::iterator it;
(*it).first;             // the key value (of type Key)
(*it).second;            // the mapped value (of type T)
(*it);                   // the "element value" (of type pair<const Key,T>) 


## unordered_map 和 map
**unordered_map**内部是希哈表的实现
**map**内部是红黑树的实现

## 习题
1.设计一个 hash集合. (可以使用 vector<vector <int>> bukckets; )

## 概念
**容器:**
顺序性容器vector、list、deque
关联容器set、multiset、map、multimap

## reference
[迭代器](https://blog.csdn.net/qq_35644234/article/details/52331948)
