# size
* list[meta header]
* std[meta namespace]
* list[meta class]
* function[meta id-type]

```cpp
size_type size() const;          // C++03
size_type size() const noexcept; // C++11
```

## 概要
コンテナの要素数を取得する。


## 戻り値
要素数を返す。


## 例外
投げない


## 計算量
- C++03 : 線形時間
- C++11 : 定数時間


## 例
```cpp example
#include <iostream>
#include <list>

int main()
{
  std::list<int> ls = {3, 1, 4, 5, 2};

  std::size_t size = ls.size();
  std::cout << size << std::endl;
}
```
* size()[color ff0000]

### 出力
```
5
```

### 備考
- GCC(libstdc++, C++11)は、5.0から定数時間。

## 参照
- [N2909 Specifying the complexity of `size()`](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2009/n2909.pdf)
- [C++0x 標準コンテナのsize()の計算量を規定 - Faith and Brave - C++で遊ぼう](http://d.hatena.ne.jp/faith_and_brave/20090902/1251879571)

