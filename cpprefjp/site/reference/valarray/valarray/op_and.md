# operator&
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> operator&(const valarray<T>& xs, const valarray<T>& ys); // (1)

  template <class T>
  valarray<T> operator&(const valarray<T>& xs, const T& y);            // (2)

  template <class T>
  valarray<T> operator&(const T& x, const valarray<T>& ys);            // (3)
}
```

## 概要
`valarray`において、左辺と右辺の論理積を得る。


- (1) : `xs`の各要素と、`ys`の各要素の論理積を得る。
- (2) : `xs`の各要素と、`y`の論理積を得る。
- (3) : `ys`の各要素と、`x`の論理積を得る。


## 戻り値

- (1) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result &= ys;
return result;
```
* &=[link op_and_assign.md]


- (2) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result &= y;
return result;
```
* &=[link op_and_assign.md]



- (3) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = ys;
result &= x;
return result;
```
* &=[link op_and_assign.md]


## 備考
2つの`valarray`オブジェクトの要素数が異なる場合、その挙動は未定義。


## 例
```cpp example
#include <cassert>
#include <valarray>
#include <cstdint>
#include <algorithm>

template <class T>
bool equal_valarray(const std::valarray<T>& a, const std::valarray<T>& b)
{
  const std::valarray<bool> result = a == b;
  return std::all_of(std::begin(result), std::end(result), [](bool b) { return b; });
}

int main()
{
  const std::valarray<std::uint8_t> a = {
    0b00000101,
    0b00001010,
    0b00010101
  };
  const std::valarray<std::uint8_t> b = {
    0b00000011,
    0b00000011,
    0b00000011
  };
  const std::valarray<std::uint8_t> expected = {
    0b00000001,
    0b00000010,
    0b00000001
  };

  std::valarray<std::uint8_t> result1 = a & b;
  assert((equal_valarray(result1, expected)));

  std::valarray<std::uint8_t> result2 = a & 0b00000011;
  assert((equal_valarray(result2, expected)));

  std::valarray<std::uint8_t> result3 = 0b00000011 & a;
  assert((equal_valarray(result3, expected)));
}
```
* std::uint8_t[link /reference/cstdint/uint8_t.md]
* std::all_of[link /reference/algorithm/all_of.md]
* std::begin[link begin_free.md]
* std::end[link end_free.md]

### 出力
```
```


