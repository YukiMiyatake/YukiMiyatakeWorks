# operator T
* atomic[meta header]
* std[meta namespace]
* atomic[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
operator T() const volatile noexcept;
operator T() const noexcept;
```

## 概要
型`T`への暗黙の型変換


## 戻り値
[`load()`](load.md)

## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <atomic>

int main()
{
  std::atomic<int> x(1);

  int value = x;
  std::cout << value << std::endl;
}
```
* int value = x;[color ff0000]a

### 出力
```
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
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013

## 参照
- [N2514 Implicit Conversion Operators for Atomics](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2514.html)

