# operator<=
* array[meta header]
* std[meta namespace]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T, size_t N>
  bool operator<=(const array<T, N>& x, const array<T, N>& y);
}
```

## 概要
`array`において、左辺が右辺以下かを判定する。


## 戻り値
`!(a` [`>`](op_greater.md) `b)`


## 計算量
線形時間


## 例
```cpp example
#include <iostream>
#include <array>

int main ()
{
  std::array<int, 3> x = {1, 2, 3};
  std::array<int, 3> y = {4, 5, 6};

  if (x <= y) {
    std::cout << "less equal" << std::endl;
  }
  else {
    std::cout << "greater" << std::endl;
  }
}
```

### 出力
```
less equal
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

