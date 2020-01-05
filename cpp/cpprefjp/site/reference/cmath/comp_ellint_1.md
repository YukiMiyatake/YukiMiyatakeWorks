# comp_ellint_1
* cmath[meta header]
* function[meta id-type]
* std[meta namespace]
* [mathjax enable]
* cpp17[meta cpp]

```cpp
namespace std {
float comp_ellint_1f(float k);
double comp_ellint_1(double k);
long double comp_ellint_1l(long double k);
}
```

## 概要
第一種完全楕円積分 (complete elliptic integral of the first kind) を計算する。


## 戻り値
引数 `k` の第一種完全楕円積分
$$
K(k) = F(k, \pi/2) = \int_0^{\pi/2} \frac{\mathrm d\theta}{\sqrt{1 - k^2 \sin^2 \theta}}
\quad \text{for } |k| \le 1
$$
を返す。
$ F(k, \phi) $ は第一種不完全楕円積分 ([`ellint_1`](ellint_1.md))。


## 例
```cpp example
#include <cmath>
#include <iostream>

int main() {
  std::cout << "comp_ellint_1(0)   = " << std::comp_ellint_1(0) << "\n";    // π / 2
  std::cout << "comp_ellint_1(0.5) = " << std::comp_ellint_1(0.5) << "\n";  // 1.68575
  std::cout << "comp_ellint_1(1)   = " << std::comp_ellint_1(1) << "\n";    // ∞
}
```
* std::comp_ellint_1[color ff0000]

### 出力例
```
comp_ellint_1(0)   = 1.5708
comp_ellint_1(0.5) = 1.68575
comp_ellint_1(1)   = nan
```


## バージョン
### 言語
- C++17

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 7.1.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


### 備考
#### GCC (libstdc++)
GCC 7.1.0–8.0.0 では定義域エラーが発生したときに [`std::numeric_limits::quiet_NaN`](/reference/limits/numeric_limits/quiet_nan.md) を返す。


## 関連項目
* 第一種不完全楕円積分 [`ellint_1`](ellint_1.md)


## 参照
- [N3060 JTC1.22.29124 Programming Language C++ — Special Math Functions](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2010/n3060.pdf)
- [WG21 P0226R1 Mathematical Special Functions for C++17, v5](https://isocpp.org/files/papers/P0226R1.pdf)
- [ISO/IEC 29124:2010 Information technology -- Programming languages, their environments and system software interfaces -- Extensions to the C++ Library to support mathematical special functions](https://www.iso.org/standard/50511.html)


## 実装例
### 級数
$$
K(k) = \frac{\pi}{2} \sum_{n=0}^\infty \left[ \frac{(2n-1)!!}{(2n)!!} \right]^2 k^{2n}
$$
