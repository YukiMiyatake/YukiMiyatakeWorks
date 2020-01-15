# next
* iterator[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class ForwardIterator>
  ForwardIterator next(ForwardIterator x,
                       typename std::iterator_traits<ForwardIterator>::difference_type n = 1); // C++11

  template <class InputIterator>
  InputIterator next(InputIterator x,
                     typename std::iterator_traits<InputIterator>::difference_type n = 1);     // C++17
}
```
* iterator_traits[link iterator_traits.md]

## 概要
`n`回進めたイテレータを返す。

[`advance()`](/reference/iterator/advance.md)と違い、引数として渡されたイテレータへの参照を書き換えるのではなく、`n`回進んだイテレータのコピーを返す。


## 効果
```cpp
advance(x, n);
return x;
```
* advance[link /reference/iterator/advance.md]


## 戻り値
引数として渡されたイテレータを`n`回進めたイテレータのコピー


## 例
```cpp example
#include <iostream>
#include <iterator>
#include <vector>

int main()
{
  std::vector<int> v = {3, 1, 4, 5, 2};

  {
    decltype(v)::iterator it = std::next(v.begin()); // イテレータを1回進める
    std::cout << *it << std::endl;
  }
  {
    decltype(v)::iterator it = std::next(v.begin(), 2); // イテレータを2回進める
    std::cout << *it << std::endl;
  }
}
```
* std::next[color ff0000]

### 出力
```
1
4
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang, C++11 mode](/implementation.md#clang): 3.0
- [GCC, C++11 mode](/implementation.md#gcc): 4.4.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照
- [boost::next() - Boost Utility Library](http://www.boost.org/doc/libs/release/libs/utility/utility.htm#functions_next_prior)
- [N2246 2 of the least crazy ideas for the standard library in C++0x](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2007/n2246.html)
- [LWG Issue 2353. `std::next` is over-constrained](https://wg21.cmeerw.net/lwg/issue2353)

