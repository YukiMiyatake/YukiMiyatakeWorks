# dynamic_pointer_cast
* memory[meta header]
* std[meta namespace]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T, class U>
  shared_ptr<T> dynamic_pointer_cast(const shared_ptr<U>& r) noexcept;
}
```

## 概要
`shared_ptr` で管理するインスタンスに対して `dynamic_cast` を行う。


## 戻り値
`r` が空であった場合、この関数は空の `shared_ptr<T>` を返却する。  
空ではない場合、この関数は `dynamic_cast<T*>` を行い `shared_ptr<T>` を返却する。  
この際、`shared_ptr<U>` の参照カウンタをそのまま使用する。(`shared_ptr<U>.use_count() == shared_ptr<T>.use_count()`)  


## 備考
`shared_ptr<T>(dynamic_cast<T*>(r.get()))` という方法は動作未定義となるので使用しないこと。


## 例外
投げない


## 例
```cpp example
#include <memory>
#include <iostream>

struct A {
  virtual void call() const {
    std::cout << "A::call" << std::endl;
  }
};

struct B : A {
  void call() const {
    std::cout << "B::call()" << std::endl;
  }
};

int main()
{
  std::shared_ptr<B> b(new B());
  std::shared_ptr<A> a = std::static_pointer_cast<A>(b);

  // AからBへのダウンキャスト
  if (std::shared_ptr<B> result = std::dynamic_pointer_cast<B>(a)) {
    result->call();
  }
  else {
    std::cout << "conversion error" << std::endl;
  }
}
```
* std::dynamic_pointer_cast[color ff0000]
* std::static_pointer_cast[link static_pointer_cast.md]

### 出力
```
B::call()
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang, C++11 mode](/implementation.md#clang): 3.0
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.6
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2008 (TR1), 2010, 2012, 2013

