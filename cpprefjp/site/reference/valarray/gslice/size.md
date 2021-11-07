# size
* valarray[meta header]
* std[meta namespace]
* gslice[meta class]
* function[meta id-type]

```cpp
valarray<std::size_t> size() const;
```
* valarray[link /reference/valarray/valarray.md]

## 概要
スライスを生成する要素数群を取得する。


## 戻り値
スライスを生成する要素数群。

## 例
```cpp example
#include <valarray>
#include <iostream>

auto main()
  -> int
{
  constexpr auto             start   = 3;
  std::valarray<std::size_t> lengths = {  3, 4 };
  std::valarray<std::size_t> strides = { 10, 3 };

  std::gslice gs( start, lengths, strides );

  for ( auto x : gs.size() )
    std::cout << x << "\n";
  std::cout << std::flush;
}
```
* size()[color ff0000]
* std::valarray[link /reference/valarray/valarray.md]

### 出力
```
3
4
```
