# const_pointer_cast
* memory[meta header]
* std[meta namespace]
* shared_ptr[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T, class U>
  shared_ptr<T> const_pointer_cast(const shared_ptr<U>& r) noexcept;
}
```

## 概要
`shared_ptr` で管理するインスタンスに対して `const_cast` を行う。 


## 戻り値
`r` が空であった場合、この関数は空の `shared_ptr<T>` を返却する。  
空ではない場合、この関数は `const_cast<T*>` を行い `shared_ptr<T>` を返却する。  
この際、`shared_ptr<U>` の参照カウンタをそのまま使用する。(`shared_ptr<U>.use_count() == shared_ptr<T>.use_count()`)  


## 備考
`shared_ptr<T>(const_cast<T*>(r.get()))` という方法は動作未定義となるので使用しないこと。


## 例外
投げない


## 例
```cpp example
#include <memory>
#include <iostream>

int main()
{
  std::shared_ptr<const int> cp(new int(3));
  std::shared_ptr<int> p = std::const_pointer_cast<int>(cp);

  std::cout << *p << std::endl;
}
```
* std::const_pointer_cast[color ff0000]

### 出力
```
3
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang, C++11 mode](/implementation.md#clang): 3.0
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.6
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2008 (TR1), 2010, 2012, 2013

