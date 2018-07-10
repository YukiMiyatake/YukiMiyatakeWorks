# operator++
* iterator[meta header]
* std[meta namespace]
* move_iterator[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
move_iterator& operator++();
move_iterator operator++(int);
```

## 概要
イテレータをインクリメントする。


## 効果
- 前置インクリメント `operator++()`：

```cpp
++base();
return *this;
```
* base[link base.md]

- 後置インクリメント `operator++(int)`：

```cpp
move_iterator tmp = *this;
++base();
return tmp;
```
* base[link base.md]


## 例
```cpp example
#include <iostream>
#include <vector>
#include <memory>
#include <iterator>

int main()
{
  std::vector<std::unique_ptr<int>> v;
  for (int i = 0; i < 5; ++i)
    v.emplace_back(new int(i));

  auto it = std::make_move_iterator(v.begin());
  ++it; // ひとつ進める
  std::unique_ptr<int> p = *it;

  std::cout << *p << std::endl;
}
```
* v.emplace_back[link /reference/vector/emplace_back.md]
* std::make_move_iterator[link /reference/iterator/make_move_iterator.md]

### 出力
```
1
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.6.1
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照


