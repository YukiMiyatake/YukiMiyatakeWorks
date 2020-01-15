# exit
* cstdlib[meta header]
* std[meta namespace]
* function[meta id-type]

```cpp
namespace std {
  void exit(int status);              // C++03
  [[noreturn]] void exit(int status); // C++11
}
```

## 概要
プログラムを終了させる。

パラメータとして渡された`status`は、プログラムの終了コードとして使用される。

- プログラムを正常終了させたい場合は、`0`もしくは[`EXIT_SUCCESS`](exit_success.md)をパラメータ`status`に設定する。
- プログラムを異常終了させたい場合は、[`EXIT_FAILURE`](exit_failure.md)をパラメータ`status`に設定する。

この関数でプログラムを終了させた場合、生存しているオブジェクトおよびストリームは、自動的に破棄される。


## 効果
1. スレッド生存期間を持つオブジェクトが破棄される。
2. 静的生存期間を持つオブジェクトが破棄される。
3. [`atexit()`](atexit.md)関数で登録された関数が、逆順に呼び出される。
    - 登録された関数で例外が送出された場合、[`std::terminate()`](/reference/exception/terminate.md)関数が呼び出され、プログラムが異常終了する。
4. 全てのCストリームが破棄される。
    - まだ書き出されていないバッファリングされたデータはフラッシュされる。
    - ストリームが閉じられる。
    - [`tmpfile()`](/reference/cstdio/tmpfile.md.nolink)関数の呼び出しで作成された一時ファイルが削除される。
5. ホスト環境に制御が戻される。
    - パラメータ`status`の値が`0`もしくは[`EXIT_SUCCESS`](exit_success.md)であった場合、実装依存の正常終了値が返る。
    - パラメータ`status`の値が[`EXIT_FAILURE`](exit_failure.md)であった場合、実装依存の異常終了値が返る。
    - それ以外の場合には、実装依存の値が返る。


## 戻り値
この関数は決して返らない。


## 例
```cpp example
#include <cstdlib>

void f()
{
  std::exit(0); // プログラムを正常終了させる
}

int main()
{
  f();
}
```
* std::exit[color ff0000]

### 出力
```
```


## 関連項目

| 名前 | 説明 |
|------|------|
| [`atexit`](atexit.md) | プログラムが通常の方法で終了するときに呼ばれる関数を登録する |
| [`quick_exit`](quick_exit.md) | 後処理をせずに、プログラムを終了させる |


