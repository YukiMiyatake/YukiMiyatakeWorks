# is_placeholder
* functional[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_placeholder;

  template <class T>
  constexpr int is_placeholder_v = is_placeholder<T>::value; // C++17
}
```

## 概要
型 `T` がプレースホルダかどうかを判別する

## 要件
`is_placeholder `は、型 `T `がプレースホルダを示す(`std::placeholders::_1`, `std::placeholders::_2`, ...)ならば [`std::integral_constant`](/reference/type_traits/integral_constant.md)`<int, J>` から派生(ただし、`J` は何番目のプレースホルダを示すかの値)し、そうでなければ [`std::integral_constant`](/reference/type_traits/integral_constant.md)`<int, 0>` から派生する。

ヒント: ユーザ定義の型に対して `is_placeholder` を特殊化してプレースホルダとして扱わせることも可能である。

## 例
```cpp example
#include <functional>

static_assert(std::is_placeholder<decltype(std::placeholders::_1)>::value, "a placeholder");
static_assert(!std::is_placeholder< std::less<int> >::value, "not a placeholder");

int main() {}
```
* std::is_placeholder[color ff0000]
* std::placeholders::_1[link placeholders.md]
* std::less[link less.md]

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
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
