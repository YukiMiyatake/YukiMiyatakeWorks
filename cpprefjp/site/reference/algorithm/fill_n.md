# fill_n
* algorithm[meta header]
* std[meta namespace]
* function template[meta id-type]

```cpp
namespace std {
  template <class OutputIterator, class Size, class T>
  void fill_n(OutputIterator first, Size n, const T& value);           // C++03 まで

  template <class OutputIterator, class Size, class T>
  OutputIterator fill_n(OutputIterator first, Size n, const T& value); // C++11 から
}
```

## 概要
指定された値で出力の範囲に `n` 個を書き込む。


## 要件
- `value` は `output iterator` へ書き込み可能でなければならない。
- `Size` は `integral type` に変換可能でなければならない。


## 効果
`n` が 1 以上の場合は `[first,first + n)` 内の全ての要素に `value` を代入し、そうでない場合は何もしない。


## 戻り値
- C++03 まで  
	無し
- C++11 から  
	`n` が 1 以上の場合は `first + n`、そうでない場合は `first` を返す。


## 計算量
`n` が 1 以上の場合は `n` 回、そうでない場合は 0 回の代入を行う。


## 例
```cpp example
#include <algorithm>
#include <iostream>
#include <iterator>

int main() {
  // 3 を出力しまくる
  std::fill_n(std::ostream_iterator<int>(std::cout, ","), 10, 3);
}
```
* std::fill_n[color ff0000]

### 出力
```
3,3,3,3,3,3,3,3,3,3,
```


## 実装例
```cpp
template <class OutputIterator, class Size, class T>
# if __cplusplus >= 201103L
OutputIterator
# else
void
# endif
fill_n(OutputIterator first, Size n, const T& value) {
  while (n-- > 0)
    *first++ = value;
# if __cplusplus >= 201103L
  return first;
# endif
}
```


### 処理系
- [Clang](/implementation.md#clang):
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 
- [ICC](/implementation.md#icc): 
- [Visual C++](/implementation.md#visual_cpp): 2010, 2012, 2013, 2015
	- C++11への対応（戻り値の変更）は2012から。


## 参照
- [LWG DR865. More algorithms that throw away information](http://cplusplus.github.io/LWG/lwg-defects.html#865)  
	戻り値が追加されるきっかけとなったレポート
