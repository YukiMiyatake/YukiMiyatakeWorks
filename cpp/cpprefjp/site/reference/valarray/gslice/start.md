# start
* valarray[meta header]
* std[meta namespace]
* gslice[meta class]
* function[meta id-type]

```cpp
std::size_t start() const;
```

## 概要
スライスを生成する初期位置を取得する。


## 戻り値
スライスを生成する初期位置。


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

  std::cout << gs.start();
}
```
* start()[color ff0000]
* std::valarray[link /reference/valarray/valarray.md]

### 出力
```
3
```

