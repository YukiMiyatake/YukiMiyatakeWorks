# is_scalar
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_scalar;

  template <class T>
  constexpr bool is_scalar_v = is_scalar<T>::value; // C++17
}
```

## 概要
型`T`がスカラ型か調べる。スカラ型は、算術型、列挙型、ポインタ型、メンバポインタ型、`std::nullptr_t`、およびそれらのcv修飾を含む。


## 効果
`is_scalar`は、型`T`がスカラ型であるならば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。


## 例
```cpp example
#include <type_traits>

static_assert(std::is_scalar<int>::value == true, "value == true, int is scalar");
static_assert(std::is_same<std::is_scalar<int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_scalar<int>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_scalar<int>() == true, "is_scalar<int>() == true");

static_assert(std::is_scalar<void>::value == false, "value == false, void is not scalar");
static_assert(std::is_same<std::is_scalar<void>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_scalar<void>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_scalar<void>() == false, "is_scalar<void>() == false");

enum e{};
class c{};
union u{};
static_assert(std::is_scalar<e>::value == true, "enum is scalar");
static_assert(std::is_scalar<c>::value == false, "class is not scalar");
static_assert(std::is_scalar<u>::value == false, "union is not scalar");
static_assert(std::is_scalar<const volatile int>::value == true, "const volatile int is scalar");
static_assert(std::is_scalar<int*>::value == true, "int* is scalar");
static_assert(std::is_scalar<int[1]>::value == false, "int[1] is not scalar");
static_assert(std::is_scalar<int&>::value == false, "int& is not scalar");
static_assert(std::is_scalar<int ()>::value == false, "int () is not scalar");
static_assert(std::is_scalar<std::nullptr_t>::value == true, "std::nullptr_t is scalar");

struct s
{
  int member_object;        // decltype(&s::member_object) は int s::*
  void member_function(){}; // decltype(&s::member_function) は void (s::*)()
};
static_assert(std::is_scalar<int s::*>::value == true, "int s::* is scalar");
static_assert(std::is_scalar<void (s::*)()>::value == true, "void (s::*)() is scalar");

int main(){}
```
* std::is_scalar[color ff0000]
* std::nullptr_t[link /reference/cstddef/nullptr_t.md]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.4, 4.5.3, 4.6.2, 4.7.0
- [Visual C++](/implementation.md#visual_cpp): 2010, 2012, 2013, 2015
	- 2010～2012は、`is_scalar<`[`nullptr_t`](../cstddef/nullptr_t.md)`>`が`false_type`からの派生クラスとなっている

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 2010 は `integral_constant` が `operator bool()` を持っていないためエラーになる。


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
