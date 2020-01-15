# swap
* queue[meta header]
* std[meta namespace]
* queue[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
void swap(queue& q) noexcept(noexcept(swap(c, q.c)))
```

## 概要
他の`queue`オブジェクトと値を入れ替える。


## 効果
`swap(c, q.c)`


## 戻り値
なし


## 例外
`swap(c, q.c)` が例外を投げない場合、この関数は決して例外を投げない。


## 例
```cpp example
#include <iostream>
#include <queue>

template <class Queue>
void pop_print(Queue& que)
{
  while (!que.empty()) {
    std::cout << que.front() << " ";
    que.pop();
  }
  std::cout << std::endl;
}

int main ()
{
  std::queue<int> x;
  x.push(1);
  x.push(2);
  x.push(3);

  std::queue<int> y;
  y.push(4);
  y.push(5);
  y.push(6);

  x.swap(y);

  pop_print(x);
  pop_print(y);
}
```
* swap[color ff0000]
* push[link push.md]
* que.empty()[link empty.md]
* que.front()[link front.md]
* que.pop()[link pop.md]

### 出力
```
4 5 6 
1 2 3 
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): ??
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 


## 参照

