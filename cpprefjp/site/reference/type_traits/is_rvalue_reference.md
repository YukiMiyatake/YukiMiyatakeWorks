# is_rvalue_reference
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_rvalue_reference;

  template <class T>
  constexpr bool is_rvalue_reference_v = is_rvalue_reference<T>::value; // C++17
}
```

## 概要
型`T`が右辺値参照型かを調べる


## 効果
`is_rvalue_reference`は、型`T`が右辺値参照型であるならば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。


## 備考
左辺値参照型は右辺値参照型ではない。


## 例
```cpp example
#include <type_traits>

static_assert(std::is_rvalue_reference<int&&>::value == true, "value == true, int&& is rvalue reference");
static_assert(std::is_same<std::is_rvalue_reference<int&&>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_rvalue_reference<int&&>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_rvalue_reference<int&&>() == true, "is_rvalue_reference<int&&>() == true");

static_assert(std::is_rvalue_reference<int>::value == false, "value == false, int is not rvalue reference");
static_assert(std::is_same<std::is_rvalue_reference<int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_rvalue_reference<int>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_rvalue_reference<int>() == false, "is_rvalue_reference<int>() == false");

static_assert(std::is_rvalue_reference<unsigned&&>::value == true, "unsigned&& is rvalue reference");
static_assert(std::is_rvalue_reference<const long&&>::value == true, "const long&& is rvalue reference");
static_assert(std::is_rvalue_reference<const double*&&>::value == true, "const double*&& is rvalue reference");
static_assert(std::is_rvalue_reference<void (&&)()>::value == true, "void (&&)() is rvalue reference");

static_assert(std::is_rvalue_reference<int*>::value == false, "int* is not rvalue reference");
static_assert(std::is_rvalue_reference<int&>::value == false, "int& is not rvalue reference");
static_assert(std::is_rvalue_reference<void ()>::value == false, "void () is not rvalue reference");
static_assert(std::is_rvalue_reference<void (int&&)>::value == false, "void (int&&) is not rvalue reference");

int main(){}
```
* std::is_rvalue_reference[color ff0000]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- GCC, C++11 mode: 4.3.4, 4.5.3, 4.6.1, 4.7.2
- [Visual C++](/implementation.md#visual_cpp): 2010, 2012, 2013, 2015
	- 2010は、関数への右辺値参照（上記例のうち`void (&&)()`）において、誤って`false_type`になっている。

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 2010 は [`integral_constant`](integral_constant.md) が `operator bool()` を持っていないためエラーになる。また、Visual C++ 2010 はコンパイラにバグがあるために関数への右辺値参照型を `is_rvalue_reference` へ渡すと `is_rvalue_reference` は `false_type` から派生してしまいエラーになる。


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
