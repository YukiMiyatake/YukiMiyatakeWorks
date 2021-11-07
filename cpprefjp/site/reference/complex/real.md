# real
* complex[meta header]
* std[meta namespace]
* function template[meta id-type]

```cpp
namespace std {
  template <class T>
  T real(const complex<T>& x);				// C++11 まで

  template <class T>
  constexpr T real(const complex<T>& x);	// C++14 から

  Promoted real(Arithmetic x);				// 追加のオーバーロード：C++11

  constexpr Promoted real(Arithmetic x);	// 追加のオーバーロード：C++14 から
}
```
* Promoted[italic]
* Arithmetic[italic]

## 概要
複素数の実部を取得する。

なお、C++11 で追加されたオーバーロードは、以下のように規定されている。

- 実引数の型が `long double` の場合、`complex<long double>` にキャストされているかのように振る舞う。
- そうでなくて、実引数の型が `double` か整数型の場合、`complex<double>` にキャストされているかのように振る舞う。
- そうでなくて、実引数の型が `float` の場合、`complex<float>` にキャストされているかのように振る舞う。

また、これらの追加のオーバーロードが関数テンプレートなのか否か、あるいは、引数が参照型なのか否かなどについては、規格では何も言及されていない。


## 戻り値
引数に指定した複素数 `x` の実部（`x.`[`real`](complex/real.md)`()`）


## 備考
- 同名のメンバ関数 [`real`](complex/real.md) も存在する。
- C++14 から `constexpr` 関数になっている。


## 例
```cpp example
#include <iostream>
#include <complex>

int main()
{
  std::complex<double> c(1.0, 2.0);

  double result = std::real(c);
  std::cout << c << ", real part = " << result << std::endl;
}
```
* std::real[color ff0000]

### 出力
```
(1,2), real part = 1
```


## バージョン
### 言語
- C++98（追加のオーバーロードは C++11 から）

### 処理系
- [Clang](/implementation.md#clang): 3.0, 3.1, 3.2, 3.3, 3.4（追加のオーバーロード含む）
- [GCC](/implementation.md#gcc): 4.3.6, 4.4.7, 4.5.4, 4.6.4, 4.7.3, 4.8.1, 4.8.2, 4.9.0（追加のオーバーロード以外）
- [GCC, C++11 mode](/implementation.md#gcc): 4.3.6, 4.4.7, 4.5.4, 4.6.4, 4.7.3, 4.8.1, 4.8.2, 4.9.0（追加のオーバーロード含む）
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??

### 備考
- libc++（[Clang](/implementation.md#clang)）は C++11 モード以降でなくても追加のオーバーロードを使用可能だが、constexpr になるのは C++14 モードだけである。  
	一方、libstdc++（[GCC](/implementation.md#gcc)）は C++11 モード以降でないと追加のオーバーロードは使用不可能だが、C++11 モードでも追加のオーバーロード以外は constexpr である。  
	なお、libstdc++ では追加のオーバーロードが constexpr になっていないが、これはバグであるものと思われる。


## 参照
- [N3302 Constexpr Library Additions: complex, v2](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2011/n3302.html)


## 関連項目

| 名前                               | 説明                                           |
|------------------------------------|------------------------------------------------|
| [`real`](complex/real.md)          | 実部を取得、あるいは、設定する。（メンバ関数） |
| [`imag`](complex/imag.md)          | 虚部を取得、あるいは、設定する。（メンバ関数） |
| [`imag`](imag.md)                  | 虚部を取得する。                               |
| [`abs`](abs.md)                    | 複素数の絶対値を得る。                         |
| [`arg`](arg.md)                    | 複素数の偏角を得る。                           |
| [`norm`](norm.md)                  | 複素数体のノルムを得る。                       |
| [`conj`](conj.md)                  | 共役複素数を得る。                             |
| [`proj`](proj.md)                  | リーマン球面への射影を得る。                   |
| [`polar`](polar.md)                | 指定した絶対値と偏角の複素数値を得る。         |
