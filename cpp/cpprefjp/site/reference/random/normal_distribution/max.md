# max
* random[meta header]
* std[meta namespace]
* normal_distribution[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
result_type max() const;
```

## 概要
生成し得る値の上限を取得する。


## 戻り値
値の範囲の上限を返す。


## 備考
- Boost.Randomおよびlibc++(Clang)の実装では、[`numeric_limits`](/reference/limits/numeric_limits.md)`::`[`infinity()`](/reference/limits/numeric_limits/infinity.md)を返す。
- libstdc++(GCC)の実装では、[`numeric_limits`](/reference/limits/numeric_limits.md)`::`[`max()`](/reference/limits/numeric_limits/max.md)を返す。


## 例
```cpp example
#include <iostream>
#include <random>

int main()
{
  std::normal_distribution<> dist(0.0, 1.0);

  double max_val = dist.max();
  std::cout << max_val << std::endl;
}
```
* max()[color ff0000]

### 出力例
```
inf
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): 3.0
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.2
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照


