# operator==
* system_error[meta header]
* std[meta namespace]
* error_category[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
bool operator==(const error_category& rhs) const noexcept;
```

## 概要
`error_category`が同じオブジェクトかどうかを判定する。

同じオブジェクトであれば`true`、そうでなければ`false`を返す。


## 戻り値
`this == &rhs`


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <system_error>

int main()
{
  const std::error_category& a = std::generic_category();
  const std::error_category& b = std::generic_category();
  const std::error_category& c = std::system_category();

  std::cout << std::boolalpha;

  std::cout << (a == b) << std::endl;
  std::cout << (a == c) << std::endl;
}
```
* std::generic_category()[link /reference/system_error/generic_category.md]
* std::system_category()[link /reference/system_error/system_category.md]

### 出力
```
true
false
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.6.1
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2010


## 参照
