# insert
* unordered_map[meta header]
* std[meta namespace]
* unordered_multimap[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
iterator insert(const value_type& v);                          // (1)

template <class P>
iterator insert(P&& obj);                                      // (2)

iterator insert(const_iterator position, const value_type& v); // (3)

template <class P>
iterator insert(const_iterator position, P&& obj);             // (4)

template <class InputIterator>
void insert(InputIterator first, InputIterator last);          // (5)

void insert(initializer_list<value_type> il);                  // (6)
```
* initializer_list[link /reference/initializer_list/initializer_list.md]

## 概要
コンテナに要素を追加する。


## 要件
- `v` を引数にとる形式（(1)、(3)）では、`value_type` はコンテナに対してコピー挿入可能（CopyInsertable）でなければならない。  
	コンテナに対してコピー挿入可能とは、`m` をアロケータ型 `allocator_type` の左辺値、`p` を要素型 `value_type` へのポインタとすると、以下の式が適格（well-formed）であるということである。

	`std::`[`allocator_traits`](/reference/memory/allocator_traits.md)`<allocator_type>::`[`construct`](/reference/memory/allocator_traits/construct.md)`(m, p, v);`

- `obj` を引数にとる形式（(2)、(4)）では、`value_type` は引数 `obj` からコンテナに対して直接構築可能（EmplaceConstructible）でなければならない。  
	コンテナに対して直接構築可能とは、`m` をアロケータ型 `allocator_type` の左辺値、`p` を要素型 `value_type` へのポインタとすると、以下の式が適格（well-formed）であるということである。

	`std::`[`allocator_traits`](/reference/memory/allocator_traits.md)`<allocator_type>::`[`construct`](/reference/memory/allocator_traits/construct.md)`(m, p, std::`[`forward`](/reference/utility/forward.md)`<P>(obj));`

- 引数 `position` は、コンテナの有効な読み取り専用イテレータでなければならない。  
	なお、規格書では間接参照可能（dereferenceable）である必要があることになっているが、その必要はない（つまり、最終要素の次を指すイテレータでも良い）ものと思われる。

- 引数 `first`、および、`last`は、入力イテレータの要件を満たし、かつ、範囲 `[first, last)` が当該コンテナ**以外を指す**有効な範囲でなければならない。  
	また、引数 `first`、および、`last` を引数にとる形式（(5)）では、このコンテナの要素型 `value_type` は、コンテナに対して `*first` から直接構築可能（EmplaceConstructible）でなければならない。  
	ここで、コンテナに対して `*first` から直接構築可能とは、`m` をアロケータ型 `allocator_type` の左辺値、`p` を要素型 `value_type` へのポインタとすると、以下の式が適格（well-formed）であるということである。

	`std::`[`allocator_traits`](/reference/memory/allocator_traits.md)`<allocator_type>::`[`construct`](/reference/memory/allocator_traits/construct.md)`(m, p, *first);`

	なお、`first`、および、`last`は、規格書では `value_type` を参照しなければならない（つまり、コンテナの `value_type` と `std::`[`iterator_traits`](/reference/iterator/iterator_traits.md)`<decltype(first)>::value_type` が同一の型でなければならない）ことになっているが、実際にはその必要はなく、上記の直接構築可能の要件を満たすだけで良いものと思われる。

- (6)の形式では、`value_type` はコンテナに対してコピー挿入可能でなければならない。


## 効果
- (1) : 引数 `v` で指定した値の要素を追加する。
- (2) : 引数 `obj` から構築されたオブジェクト `v` を追加する。
    - このバージョンの動作は、[`emplace`](emplace.md)`(`[`std::forward`](/reference/utility/forward.md)`<P>(obj))`を呼び出した場合と同等である。
- (3) : 引数 `v` で指定した値の要素を追加する。  
	引数 `position` は、要素の挿入位置を探し始める場所のヒントとして使用されるが、実装によって無視されるかもしれない。
- (4) : 引数 `obj` から構築されたオブジェクト `v` を追加する。  
	引数 `position` は、要素の挿入位置を探し始める場所のヒントとして使用されるが、実装によって無視されるかもしれない。
    - このバージョンの動作は、[`emplace_hint`](emplace_hint.md)`(hint,` [`std::forward`](/reference/utility/forward.md)`<P>(obj))`を呼び出した場合と同等である。
- (5) : 範囲 `[first, last)` のすべての要素 `t` に対して、`insert(t)` を呼び出した場合と同等である（`*first` の型によって (1)、あるいは(2)の形式が呼び出される）。
- (6) : (5)の形式を `insert(il.begin(), il.end())` として呼び出した場合と同等である。


## 戻り値
- (1)から(4) : 追加された要素を指すイテレータ。
- (5)、(6) : なし


## 例外
単一要素の形式（(1)から(4)）では、ハッシュ関数以外から例外が投げられた場合には、挿入はされない。


## 計算量
- (1)から(4)	平均的なケースでは定数（O(1)）だが、最悪のケースではコンテナの要素数 [`size`](size.md)`()` に比例（O(N)）。
- (5)	平均的なケースでは引数の範囲の要素数 `std::`[`distance`](/reference/iterator/distance.md)`(first, last)` に比例（O(N)）するが、最悪のケースでは引数の範囲の要素数 `std::`[`distance`](/reference/iterator/distance.md)`(first, last)` とコンテナの要素数 [`size()`](size.md) に 1 加えたものの積に比例（O(`std::`[`distance`](/reference/iterator/distance.md)`(first, last) * (`[`size`](size.md)`() + 1)`)）。
- (6)	(5)の形式を `insert(il.begin(), il.end())` として呼び出した場合と同等。


## 備考
- これらの関数が呼ばれた後も、当該コンテナ内の要素を指す参照は無効にはならない。
	なお、規格書に明確な記載は無いが、当該コンテナ内の要素を指すポインタも無効にはならない。

- これらの関数が呼ばれた後も、呼び出しの前後でこのコンテナのバケット数（[`bucket_count`](bucket_count.md)`()` の戻り値）が変わらなかった場合には当該コンテナを指すイテレータは無効にはならない。  
	それ以外の場合は、当該コンテナを指すイテレータは無効になる可能性がある。  
	コンテナのバケット数が変わらない場合とは、要素追加後の要素数が、要素追加前のバケット数（[`bucket_count`](bucket_count.md)`()` の戻り値）×最大負荷率（[`max_load_factor`](max_load_factor.md)`()` の戻り値）よりも小さかった場合である。  
	なお、条件が「よりも小さい」となっているが、最大負荷率の定義からすると「以下」の方が適切と思われる。[`reserve`](reserve.md) も参照。

- (2)、および、(4) の形式は、`P` が `value_type` に暗黙変換可能でなければオーバーロード解決の対象にはならない。  
	但し、この条件は規格書が当初意図した条件よりも厳しい（※）ため、C++14 では「`std::is_constructible<value_type, P&&>::value` が `true` であること」に修正される予定である。  
	※ `key_type` がムーブのみ可能（コピー不可能）の場合、`std::`[`pair`](/reference/utility/pair.md)`<key_type, mapped_type>` から `std::`[`pair`](/reference/utility/pair.md)`<const key_type, mapped_type>` へ暗黙変換可能ではない

- `position` を引数にとる形式（(3)、(4)）の場合、本関数呼び出しで構築されるオブジェクトを `t` とすると、`t.first` と等価なキーの要素が既に存在する場合、`position` に応じて既存の要素と新規の要素が順序付けられると期待されるが、規格書にそのような規定は存在しない。
	従って、そのような期待はすべきではない。[`emplace_hint`](emplace_hint.md)も参照。


## 例
```cpp example
#include <iostream>
#include <unordered_map>
#include <forward_list>
#include <algorithm>
#include <string>
#include <utility>
#include <initializer_list>

using cis = std::pair<const int, std::string>;
using is  = std::pair<int, std::string>;

std::ostream& operator<<(std::ostream& os, const cis& p)
{
    return os << '(' << p.first << ',' << p.second << ')';
}

template <class C>
void print(const char* label, const C& c, std::ostream& os = std::cout)
{
  os << label << " : ";
  std::for_each(c.cbegin(), c.cend(), [&os](const cis& p) { os << p << ", "; });
  os << '\n';
}

int main()
{
  // 一つの要素を挿入（(1)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    auto it1 = um.insert(cis{6, "6th"}); // 重複のないケース
    std::cout << *it1 << ' ';
    auto it2 = um.insert(cis{2, "2nd"}); // 重複のあるケース
    std::cout << *it2 << std::endl;
    print("insert one element", um);
  }

  // 一つの要素を挿入（(2)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    auto it1 = um.insert(is{6, "6th"}); // 重複のないケース
    std::cout << *it1 << ' ';
    auto it2 = um.insert(is{2, "2nd"}); // 重複のあるケース
    std::cout << *it2 << std::endl;
    print("insert one element", um);
  }

  // 一つの要素を挿入（(3)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    auto it1 = um.insert(um.cbegin(), cis{6, "6th"}); // 重複のないケース
    std::cout << *it1 << ' ';
    auto it2 = um.insert(um.cbegin(), cis{2, "2nd"}); // 重複のあるケース
    std::cout << *it2 << std::endl;
    print("insert one element with hint", um);
  }

  // 一つの要素を挿入（(4)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    auto it1 = um.insert(um.cbegin(), is{6, "6th"}); // 重複のないケース
    std::cout << *it1 << ' ';
    auto it2 = um.insert(um.cbegin(), is{2, "2nd"}); // 重複のあるケース
    std::cout << *it2 << std::endl;
    print("insert one element with hint", um);
  }

  // 複数の要素を挿入（(5)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    std::forward_list<std::pair<short, const char*>> fl{ {5, "5th"}, {6, "6th"}, {0, "0th"}, {8, "8th"}, {7, "7th"}, };
    um.insert(fl.cbegin(), fl.cend()); // forward_list の要素を全部
    print("insert range", um);
  }

  // 複数の要素を挿入（(6)の形式）
  {
    std::unordered_multimap<int, std::string> um{ {0, "zero"}, {1, "one"}, {2, "two"}, {3, "three"}, {4, "four"}, {5, "five"}, };

    um.insert({ {5, "5th"}, {6, "6th"}, {0, "0th"}, {8, "8th"}, {7, "7th"}, });
    print("insert initializer_list", um);
  }
}
```
* insert[color ff0000]
* um.cbegin()[link cbegin.md]
* um.cend()[link cend.md]
* std::forward_list[link /reference/forward_list/forward_list.md]
* fl.cbegin()[link /reference/forward_list/forward_list/cbegin.md]
* fl.cend()[link /reference/forward_list/forward_list/cend.md]

### 出力
```
(6,6th) (2,2nd)
insert one element : (6,6th), (5,five), (4,four), (3,three), (2,2nd), (2,two), (1,one), (0,zero), 
(6,6th) (2,2nd)
insert one element : (6,6th), (5,five), (4,four), (3,three), (2,2nd), (2,two), (1,one), (0,zero), 
(6,6th) (2,2nd)
insert one element with hint : (6,6th), (5,five), (4,four), (3,three), (2,2nd), (2,two), (1,one), (0,zero), 
(6,6th) (2,2nd)
insert one element with hint : (6,6th), (5,five), (4,four), (3,three), (2,2nd), (2,two), (1,one), (0,zero), 
insert range : (7,7th), (8,8th), (6,6th), (5,5th), (5,five), (4,four), (3,three), (2,two), (1,one), (0,0th), (0,zero), 
insert initializer_list : (7,7th), (8,8th), (6,6th), (5,5th), (5,five), (4,four), (3,three), (2,two), (1,one), (0,0th), (0,zero), 
```

注：[`unordered_multimap`](/reference/unordered_map/unordered_multimap.md) は非順序連想コンテナであるため、出力順序は無意味であることに注意


## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): -
- [Clang, C++11 mode](/implementation.md#clang): 3.1
- [GCC](/implementation.md#gcc): -
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ?
- [Visual C++](/implementation.md#visual_cpp): ?

## 実装例
(3)以降の形式は、(1)、および、(2)の形式を使って実装することができる。

```cpp
template <class Key, class Hash, class Pred, class Allocator>
inline iterator unordered_multimap<Key, Hash, Pred, Allocator>::insert(const_iterator, const value_type& v)
{
  return insert(v);
}

template <class Key, class Hash, class Pred, class Allocator>
template <class P>
inline iterator unordered_multimap<Key, Hash, Pred, Allocator>::insert(const_iterator, P&& obj)
{
  return insert(std::forward<P>(obj));
}

template <class Key, class Hash, class Pred, class Allocator>
template <class InputIterator>
inline void unordered_multimap<Key, Hash, Pred, Allocator>::insert(InputIterator first, InputIterator last);
{
  for (; first != last; ++first)
    insert(*first);
}

template <class Key, class Hash, class Pred, class Allocator>
inline void unordered_multimap<Key, Hash, Pred, Allocator>::insert(initializer_list<Key> il);
{
  insert(il.begin(), il.end());
}
```
* forward[link /reference/utility/forward.md]
* initializer_list[link /reference/initializer_list/initializer_list.md]
* insert[color ff0000]


## 関連項目

| 名前                                      | 説明                                                   |
|-------------------------------------------|--------------------------------------------------------|
| [`emplace`](emplace.md)                 | コンテナ内への要素の直接構築                           |
| [`emplace_hint`](emplace_hint.md)       | 挿入位置のヒントを使用したコンテナ内への要素の直接構築 |
| [`erase`](erase.md)                     | 要素の削除                                             |
| [`clear`](clear.md)                     | 全要素の削除                                           |
| [`swap`](swap.md)                       | 内容の交換                                             |
| [`bucket_count`](bucket_count.md)       | バケット数の取得                                       |
| [`load_factor`](load_factor.md)         | 現在の負荷率（バケットあたりの要素数の平均）を取得     |
| [`max_load_factor`](max_load_factor.md) | 負荷率の最大値を取得、設定                             |
| [`rehash`](rehash.md)                   | 最小バケット数指定によるバケット数の調整               |
| [`reserve`](reserve.md)                 | 最小要素数指定によるバケット数の調整                   |


## 参照
- [N2679 Initializer Lists for Standard Containers(Revision 1)](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2679.pdf)
    - (6)の経緯となる提案文書
- [LWG Issue 518. Are `insert` and `erase` stable for `unordered_multiset` and `unordered_multimap`?](http://www.open-std.org/jtc1/sc22/wg21/docs/lwg-defects.html#518)
    - 安定性の保証が規定された経緯のレポート
- [LWG Issue 2005. `unordered_map::insert(T&&)` protection should apply to `map` too](http://www.open-std.org/jtc1/sc22/wg21/docs/lwg-defects.html#2005)


