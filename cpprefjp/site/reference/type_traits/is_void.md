# is_void
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_void;

  template <class T>
  constexpr bool is_void_v = is_void<T>::value; // C++17
}
```

## 概要
型`T`が`void`か調べる


## 効果
`is_void`は、型`T`が`void`(cv修飾を許容する)であれば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。


## 例
```cpp example
#include <type_traits>

static_assert(std::is_void<void>::value == true, "value == true, void is void");
static_assert(std::is_same<std::is_void<void>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_void<void>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_void<void>() == true, "is_void<void>() == true");

static_assert(std::is_void<int>::value == false, "value == false, int is not void");
static_assert(std::is_same<std::is_void<int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_void<int>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_void<int>() == false, "is_void<int>() == false");

static_assert(std::is_void<const void>::value == true, "const void is void");
static_assert(std::is_void<volatile void>::value == true, "volatile void is void");
static_assert(std::is_void<const volatile void>::value == true, "const volatile void is void");

static_assert(std::is_void<void*>::value == false, "a pointer to void is not void");
static_assert(std::is_void<void ()>::value == false, "a function returning void is not void");

int main(){}
```
* std::is_void[color ff0000]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- GCC, C++11 mode: 4.3.4, 4.5.3, 4.6.1
- [Visual C++](/implementation.md#visual_cpp): 2008 (std::tr1), 2010, 2012, 2013, 2015

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 2010 は [`integral_constant`](integral_constant.md) が `operator bool()` を持っていないためエラーになる。


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
