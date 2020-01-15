# cbegin
* string[meta header]
* std[meta namespace]
* basic_string[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
const_iterator cbegin() const noexcept;
```

## 概要
文字列の先頭を指す読み取り専用イテレータを取得する。


## 戻り値
先頭を指す読み取り専用イテレータ。


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <string>

int main()
{
  std::string s = "hello";

  // 先頭へのイテレータを取得
  decltype(s)::const_iterator it = s.cbegin();

  // イテレータが指している要素を参照
  const char& c = *it;
  std::cout << c << std::endl;
}
```
* cbegin()[color ff0000]

### 出力
```
h
```

## 参照
