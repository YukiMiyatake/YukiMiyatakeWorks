# utility
* utility[meta header]

`<utility>`ヘッダでは、その他のライブラリの至る所で使用される、幾つかの基本的な関数やクラステンプレートを定義する。


## 演算子定義

| 名前                              | 説明                  | 対応バージョン |
|-----------------------------------|-----------------------|----------------|
| [`rel_ops`](utility/rel_ops.md) | 関係演算子(namespace) | |


## 値の入れ替え

| 名前                                | 説明                                                  | 対応バージョン |
|-------------------------------------|-------------------------------------------------------|----------------|
| [`swap`](utility/swap.md)         | 二つのオブジェクトの値を交換する(function template)   | C++11 |
| [`exchange`](utility/exchange.md) | 値を書き換え、書き換え前の値を返す(function template) | C++14 |


## 転送と移動

| 名前                                                | 説明                                                | 対応バージョン |
|-----------------------------------------------------|-----------------------------------------------------|----------------|
| [`forward`](utility/forward.md)                   | 関数テンプレートの引数を転送する(function template) | C++11          |
| [`move`](utility/move.md)                         | 左辺値を右辺値にキャストする(function template)     | C++11          |
| [`move_if_noexcept`](utility/move_if_noexcept.md) | 例外を投げないオブジェクトをムーブする(function template) | C++11    |


## 型の値

| 名前                              | 説明                                      | 対応バージョン |
|-----------------------------------|-------------------------------------------|----------------|
| [`declval`](utility/declval.md) | 指定された型の値を得る(function template) | C++11 |
| [`as_const`](utility/as_const.md) | 左辺値参照を`const`左辺値参照にする | C++17 |


## 組

| 名前                                                        | 説明                                   | 対応バージョン |
|-------------------------------------------------------------|----------------------------------------|----------------|
| [`pair`](utility/pair.md)                                 | 異なる型の二つの値の組(class template) | |
| [`make_pair`](utility/make_pair.md)                       | `pair`を構築するヘルパ関数(function template) | |
| [`piecewise_construct_t`](utility/piecewise_construct_t.md) | `pair`や`tuple`の要素型のコンストラクタ引数を直接受け取って構築するためのタグ型(class) | C++11 |
| [`piecewise_construct`](utility/piecewise_construct_t.md)   | `pair`や`tuple`の要素型のコンストラクタ引数を直接受け取って構築するためのタグ値(constant variable) | C++11 |
| `tuple`                                                     | `tuple`型の先行宣言(class template) | C++11 |


## 直接構築

| 名前 | 説明 | 対応バージョン |
|------|------|----------------|
| [`in_place_t`](utility/in_place_t.md) | 要素型のコンストラクタ引数を直接受け取って構築するためのタグ型 (class) | C++17 |
| [`in_place`](utility/in_place_t.md)   | 要素型のコンストラクタ引数を直接受け取って構築するためのタグ値 (constant variable) | C++17 |
| `in_place_type_t` | 指定した要素型のコンストラクタ引数を直接受け取って構築するためのタグ型 (class) | C++17 |
| `in_place_type`   | 指定した要素型のコンストラクタ引数を直接受け取って構築するためのタグ値 (constant variable) | C++17 |
| `in_place_index_t` | 指定位置にある要素型のコンストラクタ引数を直接受け取って構築するためのタグ型 (class) | C++17 |
| `in_place_index`   | 指定位置にある要素型のコンストラクタ引数を直接受け取って構築するためのタグ値 (constant variable) | C++17 |


## コンパイル時の整数シーケンス

| 名前 | 説明 | 対応バージョン |
|------|------|----------------|
| [`integer_sequence`](utility/integer_sequence.md) | 任意の整数型のシーケンス(class template) | C++14 |
| [`make_integer_sequence`](utility/make_integer_sequence.md) | 要素数を指定して、0から始まる整数シーケンスを生成する(type-alias) | C++14 |
| [`index_sequence`](utility/index_sequence.md) | `size_t`型の整数シーケンス(class template) | C++14 |
| [`make_index_sequence`](utility/make_index_sequence.md) | 要素数を指定して、0から始まる`size_t`型整数シーケンスを生成する(type-alias) | C++14 |
| [`index_sequence_for`](utility/index_sequence_for.md) | 型のシーケンスを、0から始まる`size_t`型整数シーケンスに変換する(type-alias) | C++14 |
