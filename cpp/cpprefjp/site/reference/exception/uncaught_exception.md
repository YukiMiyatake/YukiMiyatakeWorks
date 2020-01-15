# uncaught_exception
* exception[meta header]
* std[meta namespace]
* function[meta id-type]

```cpp
namespace std {
  bool uncaught_exception() throw();  // C++03
  bool uncaught_exception() noexcept; // C++11
}
```

## 概要
キャッチされていない例外があるかどうかを判定する。


## 戻り値
例外オブジェクトが生成され、スローされてからキャッチするまでの間に`true`を返す。

また、明示的に[`terminate()`](/reference/exception/terminate.md)を呼び出し、実際に呼び出されるまでの間に`true`を返す。

具体的には、`try`ブロック中で作られたオブジェクトのデストラクタや、スタック巻き戻し(unwind)中のデストラクタ、[`terminate()`](/reference/exception/terminate.md)の場合は生存している全てのオブジェクトのデストラクタで`true`になる。


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <exception>

struct X {
  ~X()
  {
    bool has_uncaught = std::uncaught_exception();
    std::cout << std::boolalpha << has_uncaught << std::endl;
  }
};

int main()
{
  try {
    X x;
    throw std::exception();
  }
  catch (std::exception& e) {
    std::cout << "catch" << std::endl;
  }
}
```
* std::uncaught_exception[color ff0000]
* std::exception[link exception.md]

### 出力
```
true
catch
```

## 参照
- [GotW #47 Uncaught Exceptions](http://www.gotw.ca/gotw/047.htm)
- [CWG Issue 475. When is `std::uncaught_exception()` true? (take 2)](http://www.open-std.org/jtc1/sc22/wg21/docs/cwg_defects.html#475)

