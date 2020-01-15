# operator>>
* valarray[meta header]
* std[meta namespace]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> operator>>(const valarray<T>& xs, const valarray<T>& ys); // (1)

  template <class T>
  valarray<T> operator>>(const valarray<T>& xs, const T& y);            // (2)

  template <class T>
  valarray<T> operator>>(const T& x, const valarray<T>& ys);            // (3)
}
```

## 概要
右にビットシフトする。

- (1) : `xs`の各要素を、`ys`の各要素の値だけ右シフトする。
- (2) : `xs`の各要素を、`y`の値だけ右シフトする。
- (3) : `x`の値を、`ys`の各要素の値だけ右シフトする。


## 戻り値

- (1) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result >>= ys;
return result;
```
* >>=[link op_right_shift_assign.md]


- (2) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result >>= y;
return result;
```
* >>=[link op_right_shift_assign.md]



- (3) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result(ys.size());
for (std::size_t i = 0; i < result.size(); ++i) {
  result[i] = x >> ys[i];
}
return result;
```
* size()[link size.md]


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
    0b01010001,
    0b10100000,
    0b01011000
  };
  const std::valarray<std::uint8_t> b = {
    4,
    4,
    4
  };
  const std::valarray<std::uint8_t> expected = {
    0b00000101,
    0b00001010,
    0b00000101
  };

  std::valarray<std::uint8_t> result1 = a >> b;
  assert((equal_valarray(result1, expected)));

  std::valarray<std::uint8_t> result2 = a >> 4;
  assert((equal_valarray(result2, expected)));
}
```
* std::uint8_t[link /reference/cstdint/uint8_t.md]
* std::all_of[link /reference/algorithm/all_of.md]
* std::begin[link begin_free.md]
* std::end[link end_free.md]

### 出力
```
```


