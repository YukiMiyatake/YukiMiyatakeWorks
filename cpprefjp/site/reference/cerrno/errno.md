# errno
* cerrno[meta header]
* macro[meta id-type]

```cpp
#define errno implementation-defined
```
* implementation-defined[italic]

## 概要
`errno` は、標準ライブラリのエラー状態を表すマクロである。

この変数は、以下の特徴を持つ：

- プログラム起動時に値 `0` で初期化される。  
	ただし、C++11 以降におけるスレッドとの関連については以下も参照のこと。
- マクロではあるが、本マクロの展開結果は `int` 型の変更可能な左辺値である（つまり、ユーザプロクラムにおいて代入が可能）。  
	ただし、本マクロの展開結果がオブジェクトの識別子とは限らない（例えば、展開結果が `*errno()` であるような実装が考えられる）。
- ライブラリの呼び出しでエラーが発生しなかった場合でも、`0` に設定されることはない。  
	したがって、`errno` の値でエラーの発生有無をチェックするためには、ライブラリ呼び出しの前にユーザプログラム側で `errno` を `0` に設定しなければならない。
- C++11 以降では、`errno` はスレッド毎に値を保持する。  
	この場合、プログラム起動時の初期スレッド以外の初期値は不定である。  
	なお、C++11 以前では規格にスレッドの概念が導入されていないため、規格上スレッドとの関連性は言及されていないが、通常の処理系では C++11 以降の規格と同様スレッド毎に値を保持する。


## 例
```cpp example
#include <iostream>
#include <cmath>
#include <cerrno>

int main()
{
  std::acosh(0.1f);
  if (errno == EDOM) {
    std::cout << "定義域エラー" << std::endl;
  }
}
```
* std::acosh[link /reference/cmath/acosh.md]


## 出力
```
定義域エラー
```

