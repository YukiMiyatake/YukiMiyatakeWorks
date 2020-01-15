# operator[]
* string[meta header]
* std[meta namespace]
* basic_string[meta class]
* function[meta id-type]

```cpp
const_reference operator[](size_type pos) const;          // (1) C++03
const_reference operator[](size_type pos) const noexcept; // (1) C++11

reference operator[](size_type pos);                      // (2) C++03
reference operator[](size_type pos) noexcept;             // (2) C++11
```

## 概要
`pos` 番目目の要素への参照を取得する。


## 要件
`pos <=` [`size()`](size.md)


## 戻り値
- C++03
    - `pos <` [`size()`](size.md) の場合、`*(`[`begin()`](begin.md) `+ pos)` を返す。
    - `pos ==` [`size()`](size.md)の場合、`charT()` の値を持ったオブジェクトへの参照を返す。
    - それ以外の場合は、未定義動作。

- C++11以降
    - `pos <` [`size()`](size.md) の場合、`*(`[`begin()`](begin.md) `+ pos)` を返す。
    - そうでない場合は、`charT()` の値を持ったオブジェクトへの参照を返す。
    - 後者の場合、参照を変更するべきではない。


## 例外
投げない


## 計算量
定数時間


## 例
```cpp example
#include <iostream>
#include <string>

int main()
{
  std::string s = "hello";
  char& c = s[1];

  std::cout << c << std::endl;
}
```
* s[1][color ff0000]

### 出力
```
e
```

## 参照
