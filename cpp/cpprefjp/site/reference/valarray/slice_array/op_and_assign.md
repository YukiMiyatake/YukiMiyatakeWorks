# operator&=
* valarray[meta header]
* std[meta namespace]
* slice_array[meta class]
* function[meta id-type]

```cpp
void operator&=(const valarray<T>& xs) const;
```
* valarray[link /reference/valarray/valarray.md]

## 概要
論理積の複合代入を行う。


## 効果
元となる`valarray`オブジェクトから参照によって抽出した各要素に、`xs`の各要素を論理積する。


## 戻り値
なし


## 備考
`valarray`から抽出した要素数と`xs`の要素数が異なる場合、その挙動は未定義。


## 例
```cpp example
#include <iostream>
#include <valarray>
#include <bitset>

int main()
{
  std::valarray<int> va = {
    0b00000101,
    0b00001010,
    0b00010101
  };

  const std::size_t start = 0u;  // 開始位置
  const std::size_t length = 3u; // 要素数
  const std::size_t stride = 1u; // 何個置きに処理するか

  std::slice_array<int> result = va[std::slice(start, length, stride)];

  // 抽出した要素に0b11を論理積する
  result &= std::valarray<int>(0b00000011, length);

  for (int x : va) {
    std::cout << std::bitset<8>(x).to_string() << std::endl;
  }
}
```
* std::valarray[link /reference/valarray/valarray.md]
* std::slice[link /reference/valarray/slice.md]
* to_string()[link /reference/bitset/bitset/to_string.md]

### 出力
```
00000001
00000010
00000001
```


