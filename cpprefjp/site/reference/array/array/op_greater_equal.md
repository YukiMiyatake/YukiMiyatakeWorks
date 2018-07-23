# operator>=
* array[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T, size_t N>
  bool operator>=(const array<T, N>& x, const array<T, N>& y);
}
```

## 概要
`array`において、左辺が右辺以上かを判定する。


## 戻り値
`!(a` [`<`](op_less.md) `b)`


## 計算量
線形時間


## 例
```cpp example
#include <iostream>
#include <array>

int main ()
{
  std::array<int, 3> x = {4, 5, 6};
  std::array<int, 3> y = {1, 2, 3};

  if (x >= y) {
    std::cout << "greater equal" << std::endl;
  }
  else {
    std::cout << "less" << std::endl;
  }
}
```

### 出力
```
greater equal
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2008 (std::tr1), 2010, 2012


## 参照

