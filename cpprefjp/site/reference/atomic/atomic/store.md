# store
* atomic[meta header]
* std[meta namespace]
* atomic[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
void store(T desired, memory_order order = memory_order_seq_cst) volatile noexcept;
void store(T desired, memory_order order = memory_order_seq_cst) noexcept;
```
* memory_order[link /reference/atomic/memory_order.md]
* memory_order_seq_cst[link /reference/atomic/memory_order.md]

## 概要
値を書き込む


## 要件
`order`が以下のメモリオーダーではないこと：

- [`memory_order_consume`](/reference/atomic/memory_order.md)
- [`memory_order_acquire`](/reference/atomic/memory_order.md)
- [`memory_order_acq_rel`](/reference/atomic/memory_order.md)

## 効果
`order`で指定されたメモリオーダーにしたがって、現在の値を`desired`でアトミックに置き換える。
この関数は、戻り値のない[`exchange()`](exchange.md)と見なせる。


## 戻り値
なし


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <atomic>

int main()
{
  std::atomic<int> x(1);

  x.store(2);

  std::cout << x.load() << std::endl;
}
```
* store[color ff0000]
* x.load()[link load.md]

### 出力
```
2
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


