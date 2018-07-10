# swap
* future[meta header]
* std[meta namespace]
* packaged_task[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
void swap(packaged_task& other) noexcept;
```

## 概要
他の`packaged_task`オブジェクトと値を入れ替える


## 効果
`*this`と`other`が持つ共有状態とタスクを入れ替える。


## 戻り値
なし


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <future>

int foo() { return 1; }
int bar() { return 2; }

int main()
{
  std::packaged_task<int()> task1(foo);
  std::packaged_task<int()> task2(bar);

  task1.swap(task2);

  std::future<int> f1 = task1.get_future();
  std::future<int> f2 = task2.get_future();

  task1();
  task2();

  std::cout << f1.get() << std::endl;
  std::cout << f2.get() << std::endl;
}
```
* swap[color ff0000]
* get_future()[link get_future.md]
* std::future[link /reference/future/future.md]
* get()[link /reference/future/future/get.md]

### 出力
```
2
1
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012


## 参照


