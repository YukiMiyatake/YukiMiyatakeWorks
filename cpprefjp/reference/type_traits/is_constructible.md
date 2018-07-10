# is_constructible
* type_traits[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T, class... Args>
  struct is_constructible;

  template <class T, class... Args>
  constexpr bool is_constructible_v
    = is_constructible<T, Args...>::value; // C++17
}
```

## 概要
型`T`のコンストラクタ呼出しが適格か調べる。`T( Args... )` の形式のコンストラクタ呼び出しが適格であるか。


## 要件
型`T`および、`Args...`の全ての型は、完全型でなければならない。


## 効果
- `is_constructible`は、`T( Args... )`の形式のコンストラクタ呼出しが適格であるならば[`true_type`](true_type.md)から派生し、そうでなければ[`false_type`](false_type.md)から派生する。
- C++17 : 型`T`が`void(int, char)`のような関数型、もしくは(CV修飾された)`void`である場合、[`false_type`](false_type.md)から派生する。


## 例
```cpp example
#include <type_traits>

struct s {
  explicit s(int) {} // intを引数にとるコンストラクタ
};

static_assert(std::is_constructible<s, int>::value == true, "value == true, s(int) is constructible");
static_assert(std::is_same<std::is_constructible<s, int>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_constructible<s, int>::type, std::true_type>::value, "type == true_type");
static_assert(std::is_constructible<s, int>() == true, "is_constructible<s, int>() == true");

static_assert(std::is_constructible<s, int*>::value == false, "value == false, s(int*) is not constructible");
static_assert(std::is_same<std::is_constructible<s, int*>::value_type, bool>::value, "value_type == bool");
static_assert(std::is_same<std::is_constructible<s, int*>::type, std::false_type>::value, "type == false_type");
static_assert(std::is_constructible<s, int*>() == false, "is_constructible<s, int*>() == false");

int main(){}
```
* std::is_constructible[color ff0000]

### 出力
```
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.4, 4.5.3, 4.6.2, 4.7.0
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013, 2015
	- 2012までは、可変引数テンプレートに対応していないため、不完全な実装である。
	- 2012～2013は、不具合がある模様。

#### 備考
上の例でコンパイラによってはエラーになる。GCC 4.3.4, 4.5.3, Visual C++ 11.0 は `integral_constant` が `operator bool()` を持っていないためエラーになる。


## 参照
- [N2983 Allowing Move Constructors to Throw](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2009/n2983.html)
- [LWG Issue 2560. `is_constructible` underspecified when applied to a function type](https://wg21.cmeerw.net/lwg/issue2560)
- [LWG Issue 2738. `is_constructible` with `void` types](https://wg21.cmeerw.net/lwg/issue2738)
- [P0006R0 Adopt Type Traits Variable Templates from Library Fundamentals TS for C++17](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2015/p0006r0.html)
