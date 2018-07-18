# atomic_fetch_xor_explicit
* atomic[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  T atomic_fetch_xor_explicit(
      volatile atomic<T>* object,
      T operand,
      memory_order order) noexcept;           // (1) C++11

  template <class T>
  T atomic_fetch_xor_explicit(
      volatile atomic<T>* object,
      typename atomic<T>::value_type operand,
      memory_order order) noexcept;           // (1) C++17

  template <class T>
  T atomic_fetch_xor_explicit(
      atomic<T>* object,
      T operand,
      memory_order order) noexcept;           // (2) C++11

  template <class T>
  T atomic_fetch_xor_explicit(
      atomic<T>* object,
      typename atomic<T>::value_type operand,
      memory_order order) noexcept;           // (2) C++17
}
```
* atomic[link atomic.md]
* memory_order[link memory_order.md]

## 概要
アトミックにXOR演算を行う


## 要件
- C++17 : 型`T`がオブジェクト型であること。型`T`が`void*`や関数ポインタであってはならない


## 効果
`order`で指定されたメモリオーダーにしたがって、現在の値に`operand`をXORした値でアトミックに置き換える


## 戻り値
変更前の値が返される


## 例外
投げない


## 備考
符号付き整数型に対しては、2の補数表現による演算が行われ、未定義動作はない。アドレス型に関しては結果として未定義アドレスになる場合があるが、それ以外の未定義動作はない。


## 例
```cpp example
#include <iostream>
#include <atomic>
#include <bitset>

int main()
{
  int a = 0x0b;
  int b = 0x0e;

  std::atomic<int> x(a);

  std::atomic_fetch_xor_explicit(&x, b, std::memory_order_seq_cst);

  std::cout << std::bitset<4>(a).to_string() << std::endl;
  std::cout << std::bitset<4>(b).to_string() << std::endl;
  std::cout << std::bitset<4>(x.load()).to_string() << std::endl;
}
```
* std::atomic_fetch_xor_explicit[color ff0000]
* x.load()[link /reference/atomic/atomic/load.md]
* to_string()[link /reference/bitset/to_string.md]


### 出力
```
1011
1110
0101
```


## バージョン
### 言語
- C++11


### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013


## 参照
- [P0558R1 Resolving `atomic<T>` named base class inconsistencies](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2017/p0558r1.pdf)
