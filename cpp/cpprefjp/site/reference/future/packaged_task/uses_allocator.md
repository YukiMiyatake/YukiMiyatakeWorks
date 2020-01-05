# uses_allocator
* future[meta header]
* std[meta namespace]
* class template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class R, class Alloc>
  struct uses_allocator<packaged_task<R>, Alloc>
    : true_type { };
}
```
* true_type[link /reference/type_traits/true_type.md]

## 概要
`uses_allocator`の、`packaged_task<R>`に対する特殊化。


## 例
```cpp
```

### 出力
```cpp
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012


## 参照


