# is_pointer
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  struct is_pointer;

  template <class T>
  constexpr bool is_pointer_v = is_pointer<T>::value; // C++17
}
```

## 概要
型`T`がポインタ型かを調べる


## 効果
`is_pointer`は、型`T`がポインタ型であるならば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。


## 備考
- 関数へのポインタはポインタ型であるが、`static`ではないメンバへのポインタは、ポインタ型ではない。
- `nullptr`はポインタ型へ変換できるが，[`nullptr_t`](/reference/cstddef/nullptr_t.md)型はポインタ型ではない。

## 例
```cpp example
#include <type_traits>
#include <cstddef>

static_assert(std::is_pointer<int*>::value == true, "value == true, int* is pointer");
static_assert(std::is_same<std::is_pointer<int*>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_pointer<int*>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_pointer<int*>() == true, "is_pointer<int*>() == true");

static_assert(std::is_pointer<int>::value == false, "value == false, int is not pointer");
static_assert(std::is_same<std::is_pointer<int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_pointer<int>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_pointer<int>() == false, "is_pointer<int>() == false");

static_assert(std::is_pointer<unsigned*>::value == true, "unsigned* is pointer");
static_assert(std::is_pointer<const long*>::value == true, "const long* is pointer");
static_assert(std::is_pointer<const double* const>::value == true, "const double* const is pointer");
static_assert(std::is_pointer<void (*)()>::value == true, "void (*)() is pointer");

struct s
{
  void member_function(){};
  int member_object;
};

static_assert(std::is_pointer<int[]>::value == false, "int[] is not pointer");
static_assert(std::is_pointer<int*&>::value == false, "int*& is not pointer");
static_assert(std::is_pointer<void ()>::value == false, "void () is not pointer");
static_assert(std::is_pointer<void (s::*)()>::value == false, "void s::*() is not pointer");
static_assert(std::is_pointer<int s::*>::value == false, "int s::* is not pointer");
static_assert(std::is_pointer<std::nullptr_t>::value == false, "std::nullptr_t is not pointer");

int main(){}
```
* std::is_pointer[color ff0000]
* std::nullptr_t[link /reference/cstddef/nullptr_t.md]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- GCC, C++11 mode: 4.3.4, 4.5.3, 4.6.2, 4.7.0
- [Visual C++](/implementation.md#visual_cpp): 2008 (std::tr1), 2010, 2012, 2013, 2015

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 2010.0 は [`integral_constant`](integral_constant.md) が `operator bool()` を持っていないためエラーになる。また、GCC 4,3,4, 4.5.3 は `nullptr_t` 型に対応していないためエラーになる。


## 参照
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
