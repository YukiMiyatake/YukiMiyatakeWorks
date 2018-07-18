# operator<
* string_view[meta header]
* std[meta namespace]
* function[meta id-type]
* cpp17[meta cpp]

```cpp
namespace std {
  template <class CharT, class Traits>
  constexpr bool operator<(basic_string_view<CharT, Traits> x,
                           basic_string_view<CharT, Traits> y) noexcept;
}
```

## 概要
`basic_string_view`オブジェクトにおいて、左辺が右辺より小さいかの判定を行う。


## 戻り値
```cpp
return x.compare(y) < 0;
```
* compare[link compare.md]


## 例
```cpp example
#include <iostream>
#include <string_view>

int main()
{
  std::string_view a = "aaa";
  std::string_view b = "bbb";

  if (a < b) {
    std::cout << "less" << std::endl;
  }
  else {
    std::cout << "greater equal" << std::endl;
  }
}
```

### 出力例
```
less
```

## バージョン
### 言語
- C++17

### 処理系
- [Clang, C++17 mode](/implementation.md#clang): 4.0
- [GCC, C++17 mode](/implementation.md#gcc): 7.1
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??
