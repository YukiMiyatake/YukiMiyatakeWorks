# equal_range
* unordered_set[meta header]
* std[meta namespace]
* unordered_set[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
std::pair<iterator, iterator> equal_range(const key_type& k);
std::pair<const_iterator, const_iterator> equal_range(const key_type& k) const;
```

## 概要
指定したキーの範囲を取得する


## 戻り値
キー値が引数 `k` と等価な要素を全て含む範囲。そのような要素が無い場合には、[`make_pair`](/reference/utility/make_pair.md)`(`[`end`](end.md)`(),` [`end`](end.md)`())`。


## 計算量
平均的なケースでは O([`count`](count.md)`(k)`)。最悪のケースでは O([`size`](size.md)`()`)。


## 備考
[`unordered_set`](/reference/unordered_set/unordered_set.md) の場合には、等価なキーはたかだか1つであるため、[`find`](find.md) ほど有用ではないと思われる。

## 例
```cpp example
#include <iostream>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <iterator>

template <class Iter>
void print_range(const std::string& label, Iter begin, Iter it1, Iter it2, std::ostream& os = std::cout)
{
  os << label << ": " << "[" << std::distance(begin, it1) << ", "  << std::distance(begin, it2) << ")" << std::endl;
}

int main()
{
  std::unordered_set<int> us{ 1, 3, 5, 7, 9, };

  std::copy(us.begin(), us.end(), std::ostream_iterator<int>(std::cout, ", "));
  std::cout << std::endl;

  auto p1 = us.equal_range(5);
  print_range("equal_range(5)", us.begin(), p1.first, p1.second);

  auto p2 = us.equal_range(8);
  print_range("equal_range(8)", us.begin(), p2.first, p2.second);
}
```
* equal_range[color ff0000]
* std::ostream[link /reference/ostream.md]
* us.begin()[link begin.md]
* us.end()[link end.md]
* first[link /reference/utility/pair.md]
* second[link /reference/utility/pair.md]

### 出力
```
9, 7, 5, 3, 1,
equal_range(5): [2, 3)
equal_range(8): [5, 5)
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): -
- [Clang, C++11 mode](/implementation.md#clang): 3.0, 3.1
- [GCC](/implementation.md#gcc): -
- [GCC, C++11 mode](/implementation.md#gcc): 4.4.7, 4.5.3, 4.6.3, 4.7.0
- [ICC](/implementation.md#icc): ?
- [Visual C++](/implementation.md#visual_cpp): ?

## 関連項目
| 名前 | 説明 |
|------|------|
|[`find`](find.md)|指定したキーの位置を検索|
|[`count`](count.md)|指定したキーの要素数を取得|

