# max
* chrono[meta header]
* std::chrono[meta namespace]
* duration_values[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
static constexpr Rep max()
```

## 概要
`Rep`の最大値を取得する。


## 戻り値
```cpp
numeric_limits<Rep>::max()
```
* numeric_limits[link /reference/limits/numeric_limits.md]
* max()[link /reference/limits/numeric_limits/max.md]

※戻り値は0より大きくなければならない。


## 例
```cpp example
#include <iostream>
#include <chrono>

using namespace std::chrono;

int main()
{
  std::cout << duration_values<seconds::rep>::max() << std::endl;
  std::cout << duration_values<duration<int, std::nano>::rep>::max() << std::endl;
  std::cout << duration_values<duration<double, std::nano>::rep>::max() << std::endl;
}
```
* max()[color ff0000]
* seconds[link /reference/chrono/seconds.md]
* duration[link /reference/chrono/duration.md]
* std::nano[link /reference/ratio/si_prefix.md]

### 出力例
```
9223372036854775807
2147483647
1.79769e+308
```


## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.6.1
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013, 2015
