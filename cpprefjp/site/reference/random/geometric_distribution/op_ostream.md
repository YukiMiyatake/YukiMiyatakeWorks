# operator<<
* random[meta header]
* std[meta namespace]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class CharT, class Traits, class IntType>
  std::basic_ostream<CharT, Traits>& operator<<(
    std::basic_ostream<CharT, Traits>& os
    const geometric_distribution<IntType>& x);
}
```

## 概要
ストリームへの出力を行う。


## 効果
`os`に対して、分布オブジェクト`x`の現在状態を出力する。


## 事後条件
`os`のフォーマットフラグが、この関数を呼び出す前の状態に戻ること。


## 戻り値
`os`


## 例
```cpp example
#include <iostream>
#include <random>

int main()
{
  std::geometric_distribution<> dist(0.5);
  std::cout << dist << std::endl;
}
```

### 出力例
```
5.00000000000000000e-01
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.2
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照


