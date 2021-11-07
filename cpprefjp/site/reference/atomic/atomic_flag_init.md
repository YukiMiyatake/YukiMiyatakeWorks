# ATOMIC_FLAG_INIT
* atomic[meta header]
* macro[meta id-type]
* cpp11[meta cpp]

```cpp
# define ATOMIC_FLAG_INIT see below
```
* see below[italic]


## 概要
フラグを初期化する。

このマクロは、[`atomic_flag`](atomic_flag.md)オブジェクトの初期化に使用し、フラグをクリア状態にする。静的オブジェクトに対しては、その初期化は静的に行われなければならない。


## 例
```cpp example
#include <iostream>
#include <atomic>

int main()
{
  std::atomic_flag x = ATOMIC_FLAG_INIT;

  // フラグを立て、変更前の値を確認する
  bool before = x.test_and_set();
  std::cout << std::boolalpha << before << std::endl;
}
```
* ATOMIC_FLAG_INIT[color ff0000]
* std::atomic_flag[link atomic_flag.md]
* x.test_and_set()[link atomic_flag/test_and_set.md]


### 出力
```
false
```


## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013


## 参照


