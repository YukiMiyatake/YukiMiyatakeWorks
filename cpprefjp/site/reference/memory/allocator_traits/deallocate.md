# deallocate
* memory[meta header]
* std[meta namespace]
* allocator_traits[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
static void deallocate(Alloc& a, pointer p, size_type n);
```

## 概要
メモリを解放する。


## 効果
`a.deallocate(p, n)`


## 例外
投げない


## 例
```cpp example
#include <memory>

int main()
{
  std::allocator<int> alloc;
  using traits = std::allocator_traits<decltype(alloc)>;

  // 10要素のint領域を確保する
  std::size_t n = 10;
  int* p = traits::allocate(alloc, n);

  // 確保したメモリを解放する
  traits::deallocate(alloc, p, n);
}
```
* deallocate[color ff0000]
* std::allocator[link /reference/memory/allocator.md]
* traits::allocate[link allocate.md]

### 出力
```
```


## バージョン
### 言語
- C++11

### 処理系
- [Clang, C++11 mode](/implementation.md#clang): 3.0
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.3
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013
