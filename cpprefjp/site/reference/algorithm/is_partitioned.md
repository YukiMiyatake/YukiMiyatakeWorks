# is_partitioned
* algorithm[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class InputIterator, class Predicate>
  bool is_partitioned(InputIterator first, InputIterator last, Predicate pred);
}
```

## 概要
与えられた範囲が条件によって[区分化](/reference/algorithm.md#sequence-is-partitioned)されているか判定する。


## 要件
`InputIterator`のvalue typeは `Predicate` の引数型へ変換可能でなければならない。

つまり `pred(*first)` という式が有効でなければならない。


## 戻り値
`[first,last)` が空、 または `[first,last)` が `pred` によって[区分化](/reference/algorithm.md#sequence-is-partitioned)されているなら `true` 、そうでなければ `false` を返す。

つまり、`pred` を満たす全ての要素が、`pred` を満たさない全ての要素より前に出現するなら `true` を返す。


## 計算量
線形時間。最大で `last - first` 回 `pred` が適用される。


## 例
```cpp example
#include <iostream>
#include <vector>
#include <algorithm>

int main()
{
  std::vector<int> v = {1, 2, 3, 4, 5};

  auto pred = [](int x) { return x % 2 == 0; };

  // 偶数グループと奇数グループに分ける
  std::partition(v.begin(), v.end(), pred);

  std::for_each(v.begin(), v.end(), [](int x) {
   std::cout << x << std::endl;
  });

  // 偶数グループと奇数グループに分かれているか
  if (std::is_partitioned(v.begin(), v.end(), pred)) {
    std::cout << "partitioned" << std::endl;
  }
  else {
    std::cout << "not partitioned" << std::endl;
  }
}
```
* std::is_partitioned[color ff0000]
* std::partition[link partition.md]

### 出力
```
4
2
3
1
5
partitioned
```


## 実装例
```cpp
template <class InputIterator, class Predicate>
bool is_partitioned(InputIterator first, InputIterator last, Predicate pred)
{
  first = std::find_if_not(first, last, pred);
  return (first == last) || std::none_of(++first, last, pred);
}
```
* std::none_of[link none_of.md]
* std::find_if_not[link find_if_not.md]


## バージョン
### 言語
- C++11


### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2010, 2012, 2013, 2015


## 参照
- [N2569 More STL algorithms](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2569.pdf)
- [N2666 More STL algorithms (revision 2)](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2666.pdf)

