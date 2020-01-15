# tuple_size
* array[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T> class tuple_size; // 先行宣言

  // C++11
  template <class T, std::size_t N>
  struct tuple_size<array<T, N>> {
    static constexpr std::size_t value = N;
  };

  // C++14
  template <class T, std::size_t N>
  struct tuple_size<array<T, N>>
    : integral_constant<std::size_t, N> {};
}
```
* integral_constant[link /reference/type_traits/integral_constant.md]

## 概要
`tuple_size`は、タプルとして見なせる型の要素数を取得するためのクラスである。

要素数は、[`integral_constant`](/reference/type_traits/integral_constant.md)の機能を利用してコンパイル時の定数値として取得できる。

`<array>`ヘッダでは、[`array`](/reference/array/array.md)クラスに関する特殊化を定義する。


## 例
```cpp example
#include <array>

int main()
{
  static_assert(std::tuple_size<std::array<int, 3>>::value == 3, "");
}
```
* std::tuple_size[color ff0000]


### 出力
```
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
- [LWG Issue 2313. `tuple_size` should always derive from `integral_constant<size_t, N>`](http://www.open-std.org/jtc1/sc22/wg21/docs/lwg-defects.html#2313)

