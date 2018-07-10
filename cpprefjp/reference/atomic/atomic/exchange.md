# exchange
* atomic[meta header]
* std[meta namespace]
* atomic[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
T exchange(T desired, memory_order order = memory_order_seq_cst) volatile noexcept;
T exchange(T desired, memory_order order = memory_order_seq_cst) noexcept;
```
* memory_order[link /reference/atomic/memory_order.md]
* memory_order_seq_cst[link /reference/atomic/memory_order.md]

## 概要
値を入れ替える


## 効果
`order`で指定されたメモリオーダーにしたがって、現在の値を`desired`でアトミックに置き換える


## 戻り値
変更前の値が返される


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <atomic>

int main()
{
  std::atomic<int> x(1);

  if (x.exchange(2) == 1) {
    std::cout << "replaced 1 by 2" << std::endl;
  }
  else {
    std::cout << "replace failed" << std::endl;
  }
}
```
* exchange[color ff0000]


### 出力
```
replaced 1 by 2
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


