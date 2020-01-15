# is_reference
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_reference;

  template <class T>
  constexpr bool is_reference_v = is_reference<T>::value; // C++17
}
```

## 概要
型`T`が参照型か調べる


## 効果
`is_reference`は、型`T`が左辺値参照型もしくは右辺値参照型であるならば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。


## 例
```cpp example
#include <type_traits>

static_assert(std::is_reference<int&>::value == true, "value == true, int& is reference");
static_assert(std::is_same<std::is_reference<int&>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_reference<int&>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_reference<int&>() == true, "is_reference<int&>() == true");

static_assert(std::is_reference<int>::value == false, "value == false, int is not reference");
static_assert(std::is_same<std::is_reference<int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_reference<int>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_reference<int>() == false, "is_reference<int>() == false");

static_assert(std::is_reference<float&>::value == true, "float& is reference");
static_assert(std::is_reference<unsigned&&>::value == true, "unsigned&& is reference");
static_assert(std::is_reference<long&&>::value == true, "long&& is reference");

static_assert(std::is_reference<int*>::value == false, "int* is not reference");
static_assert(std::is_reference<void (int&)>::value == false, "void (int&) is not reference");
static_assert(std::is_reference<int&& ()>::value == false, "int&& () is not reference");

int main(){}
```
* std::is_reference[color ff0000]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.4, 4.5.3, 4.6.1, 4.7.0
- [Visual C++](/implementation.md#visual_cpp): 2008 (std::tr1), 2010, 2012, 2013, 2015

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 2010.0 は [`integral_constant`](integral_constant.md) が `operator bool()` を持っていないためエラーになる。


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
