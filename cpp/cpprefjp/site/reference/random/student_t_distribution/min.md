# min
* random[meta header]
* std[meta namespace]
* student_t_distribution[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
result_type min() const;
```

## 概要
生成し得る値の下限を取得する。


## 戻り値
値の範囲の下限を返す。


## 例
```cpp example
#include <iostream>
#include <random>

int main()
{
  std::student_t_distribution<> dist(1.0);

  double min_val = dist.min();
  std::cout << min_val << std::endl;
}
```
* min()[color ff0000]

### 出力例
```
2.22507e-308
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): 3.0
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照


