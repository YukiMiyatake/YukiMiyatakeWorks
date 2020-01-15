# empty
* unordered_set[meta header]
* std[meta namespace]
* unordered_set[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
bool empty() const noexcept;
```

## 概要
コンテナが空かどうかを判定する。


## 戻り値
コンテナが空であれば `true`、そうでなければ `false` を返す。


## 例外
投げない。


## 計算量
定数


## 例
```cpp example
#include <iostream>
#include <unordered_set>

int main()
{
  std::cout << std::boolalpha;

  std::unordered_set<int> us;

  // 空
  std::cout << us.empty() << std::endl;

  us.insert(1);

  // 空ではない
  std::cout << us.empty() << std::endl;

  us.clear();

  // 空
  std::cout << us.empty() << std::endl;
}
```
* empty()[color ff0000]
* us.insert[link insert.md]
* us.clear()[link clear.md]

### 出力
```
true
false
true
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

## 実装例
```cpp
template <class Key, class Hash, class Pred, class Allocator>
inline bool unordered_set<Key, Hash, Pred, Allocator>::empty() const noexcept {
  return size() == 0; // begin() == end() でも OK
}
```
* size()[link size.md]
* begin()[link begin.md]
* end()[link end.md]

## 関連項目

| 名前                        | 説明                         |
|-----------------------------|------------------------------|
| [`size`](size.md)         | 要素数の取得                 |
| [`max_size`](max_size.md) | 格納可能な最大の要素数の取得 |

