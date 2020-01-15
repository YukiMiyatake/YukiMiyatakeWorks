# cfenv
* cfenv[meta header]
* cpp11[meta cpp]

`<cfenv>`ヘッダでは、浮動小数点環境にアクセスするための機能が定義される。

このヘッダは、IEC 60559 (IEEE 754)で定義される浮動小数点例外の状態フラグを管理することを目的として設計されている。「浮動小数点例外の状態フラグ」は、浮動小数点例外の発生によって設定されるシステム変数である。

浮動小数点環境はスレッドローカル記憶域を持ち、その初期状態は、スレッドを作成したときの浮動小数点環境の状態が設定される。

プログラム起動時、浮動小数点環境は以下のように初期化される :

- 浮動小数点例外の全ての状態がクリアされる
- 浮動小数点数の丸めモードは「最も近い値への丸め ([`FE_TONEAREST`](cfenv/fe_tonearest.md))」となる


## 浮動小数点環境

| 名前    | 説明 | 対応バージョン |
|---------|------|----------------|
| `fenv_t` | 浮動小数点環境の状態を表す型 (type-alias) | C++11 |
| `fegetenv` | 現在の浮動小数点環境を取得する (function) | C++11 |
| `fesetenv` | 浮動小数点環境を設定する (function) | C++11 |
| `feholdexcept` | 現在の浮動小数点環境を保存する (function) | C++11 |
| `feupdateenv` | 現在発生している浮動小数点例外を保存する (function) | C++11 |

### 浮動小数点環境マクロ

| 名前         | 説明 | 対応バージョン |
|--------------|------|----------------|
| `FE_DFL_ENV` | デフォルトの浮動小数点環境 (macro) | C++11 |


## 浮動小数点例外

| 名前 | 説明 | 対応バージョン |
|------|------|----------------|
| [`fexcept_t`](cfenv/fexcept_t.md) | 浮動小数点例外の状態フラグを表す整数型 (type-alias) | C++11 |
| [`feclearexcept`](cfenv/feclearexcept.md) | 指定された浮動小数点例外をクリアする (function) | C++11 |
| [`fegetexceptflag`](cfenv/fegetexceptflag.md) | 浮動小数点例外の現在の状態を、実装定義の表現で取得する (function) | C++11 |
| [`fesetexceptflag`](cfenv/fesetexceptflag.md) | 浮動小数点例外を発生させずに、浮動小数点例外の状態を設定する (function) | C++11 |
| [`feraiseexcept`](cfenv/feraiseexcept.md) | 指定された浮動小数点例外を発生させる (function) | C++11 |
| [`fetestexcept`](cfenv/fetestexcept.md) | 指定された浮動小数点例外が設定されるかを判定する (function) | C++11 |

### 浮動小数点例外マクロ

以下のマクロは、浮動小数点例外の状態を表すビット値である。これらのマクロは、AND (`&`) や OR (`|`)を使用して、複数のマクロを組み合わせて使用できる。

| 名前            | 説明                         | 対応バージョン |
|-----------------|------------------------------|----------------|
| [`FE_ALL_EXCEPT`](cfenv/fe_all_except.md) | 全ての浮動小数点例外 (macro) | C++11 |
| [`FE_DIVBYZERO`](cfenv/fe_divbyzero.md)   | ゼロ除算 (macro)             | C++11 |
| [`FE_INEXACT`](cfenv/fe_inexact.md)       | 不正確な結果 (macro)         | C++11 |
| [`FE_INVALID`](cfenv/fe_invalid.md)       | 不正な演算 (macro)           | C++11 |
| [`FE_OVERFLOW`](cfenv/fe_overflow.md)     | オーバーフロー (macro)       | C++11 |
| [`FE_UNDERFLOW`](cfenv/fe_underflow.md)   | アンダーフロー (macro)       | C++11 |


## 浮動小数点丸め

| 名前 | 説明 | 対応バージョン |
|------|------|----------------|
| [`fegetround`](cfenv/fegetround.md) | 現在の丸め方式を取得する (function) | C++11 |
| [`fesetround`](cfenv/fesetround.md) | 丸め方式を設定する (function) | C++11 |


### 浮動小数点丸めマクロ

以下のマクロは、浮動小数点の丸めがどのような方式で行われるかを表す。

| 名前            | 説明                           | 対応バージョン |
|-----------------|--------------------------------|----------------|
| [`FE_DOWNWARD`](cfenv/fe_downward.md)     | 負の無限大方向への丸め (macro) | C++11 |
| [`FE_TONEAREST`](cfenv/fe_tonearest.md)   | 最も近い値への丸め (macro)     | C++11 |
| [`FE_TOWARDZERO`](cfenv/fe_towardzero.md) | ゼロ方向への丸め (macro)       | C++11 |
| [`FE_UPWARD`](cfenv/fe_upward.md)         | 正の無限大方向への丸め (macro) | C++11 |

## バージョン
### 言語
- C++11

### 処理系
- [Clang, C++11 mode](/implementation.md#clang): ?
- [GCC, C++11 mode](/implementation.md#gcc): ?
- [ICC](/implementation.md#icc): ?
- [Visual C++](/implementation.md#visual_cpp): 2013, 2015

## 関連項目
- [`<cmath>`](/reference/cmath.md)

