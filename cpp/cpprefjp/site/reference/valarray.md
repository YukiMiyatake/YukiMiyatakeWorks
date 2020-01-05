# valarray
* valarray[meta header]

`<valarray>`ヘッダは、数値計算に特化した配列クラスである`valarray`と、基礎的な数学的処理を行うための関数オーバーロードを定義したライブラリである。

## 配列クラス

| クラス                               | 説明                          | 対応バージョン |
|--------------------------------------|-------------------------------|----------------|
| [`valarray`](valarray/valarray.md) | 数値演算に特化した配列クラス  | |


## スライス指示

以下は、`valarray`クラスの配列から条件一致した要素を抽出するための、ヘルパークラスである。

| クラス                               | 説明                          | 対応バージョン |
|--------------------------------------|-------------------------------|----------------|
| [`slice`](valarray/slice.md)       | スライス指示用のヘルパークラス | |
| [`gslice`](valarray/gslice.md)     | `slice`をより一般化したスライス指示用のヘルパークラス | |


## スライス結果の配列クラス

以下は、`valarray`クラスの[`operator[]`](/reference/valarray/valarray/op_at.md)メンバ関数によって返される、スライス結果の配列クラスである。これらのクラスは、配列のコピーは保持せず、元となる`valarray`オブジェクトの要素を参照する。

| クラス                               | 説明                          | 対応バージョン |
|--------------------------------------|-------------------------------|----------------|
| [`slice_array`](valarray/slice_array.md)   | `valarray`から`slice`によって要素抽出した結果となる配列クラス | |
| [`gslice_array`](valarray/gslice_array.md) | `valarray`から`gslice`によって要素抽出した結果となる配列クラス | |
| [`mask_array`](valarray/mask_array.md)     | `valarray`から`valarray<bool>`を指定して要素抽出した結果となる配列クラス | |
| [`indirect_array`](valarray/indirect_array.md) | `valarray`から`valarray<size_t>`を指定して要素抽出した結果となる配列クラス | |


