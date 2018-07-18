# make_move_iterator
* iterator[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class Iterator>
  move_iterator<Iterator> make_move_iterator(const Iterator& i); // C++11

  template <class Iterator>
  move_iterator<Iterator> make_move_iterator(Iterator i);        // C++14
}
```
* move_iterator[link move_iterator.md]

## 概要
`move_iterator`のヘルパ関数。


## 戻り値
```cpp
return move_iterator<Iterator>(i);
```
* move_iterator[link move_iterator.md]


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
  std::unique_ptr<int> p = *it;

  std::cout << *p << std::endl;
}
```
* std::make_move_iterator[color ff0000]

### 出力
```
0
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照
- [LWG Issue 2061. `make_move_iterator` and arrays](http://www.open-std.org/jtc1/sc22/wg21/docs/lwg-defects.html#2061)
    - C++11ではパラメータが`const Iterator&`だったが、C++14では`Iterator`に変更された。これは、組み込み配列を渡された際に、ポインタに型推論(decay)させるため。

