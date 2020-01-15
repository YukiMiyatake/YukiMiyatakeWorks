# at
* array[meta header]
* std[meta namespace]
* array[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
reference at(size_type n);                       // (1)
const_reference at(size_type n) const;           // (2) C++11
constexpr const_reference at(size_type n) const; // (2) C++14
```

## 概要
n番目の要素を参照する。


## 戻り値
`a.at(n)`は`n`番目の要素への参照を返す。もし、`a`が`const`だった場合には、`n`番目の要素への`const`参照を返す。


## 例外
`n >= a.`[`size()`](size.md)だった場合には[`out_of_range`](/reference/stdexcept.md)例外を投げる。


## 計算量
定数時間


## 備考
`a.at(n)` は `*(a.`[`begin()`](begin.md) `+ n)` と同じ結果になる。


## 例
```cpp example
#include <iostream>
#include <array>

int main()
{
  std::array<int, 3> ar = {3, 1, 4};
  const std::array<int, 3>& car = ar;

  int& a = ar.at(2);
  const int& b = car.at(2);

  std::cout << a << std::endl;
  std::cout << b << std::endl;

  try {
    ar.at(999); // 範囲外アクセス
  }
  catch (std::out_of_range& e) {
    std::cout << "out of range" << std::endl;
  }
}
```
* at[color ff0000]
* std::out_of_range[link /reference/stdexcept.md]


### 出力
```
4
4
out of range
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
- [N3470 Constexpr Library Additions: containers, v2](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3470.html)


