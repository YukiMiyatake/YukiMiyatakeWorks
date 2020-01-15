# pop
* queue[meta header]
* std[meta namespace]
* priority_queue[meta class]
* function[meta id-type]

```cpp
void pop();
```

## 概要
`priority_queue` の次の要素を削除して、要素数を１つ減らす。

削除する要素は[`top()`](top.md)メンバ関数で得られるオブジェクトであり、そのデストラクタが呼ばれる。

内部のコンテナの`pop_back()`メンバ関数を呼ぶ。


## 効果
```cpp
pop_heap(c.begin(), c.end(), comp);
c.pop_back();
```
* pop_heap[link /reference/algorithm/pop_heap.md]


## 戻り値
なし


## 例
```cpp example
#include <iostream>
#include <queue>

int main()
{
  std::priority_queue<int> que;

  que.push(3);
  que.push(1);
  que.push(4);

  que.pop(); // 4が削除される
  que.pop(); // 3が削除される
  std::cout << que.top() << std::endl;
}
```
* pop()[color ff0000]
* que.top()[link top.md]

### 出力
```
1
```

## 参照


