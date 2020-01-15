# accumulate
* numeric[meta header]
* std[meta namespace]
* function template[meta id-type]

```cpp
namespace std{
  template <class InputIterator, class T>
  T accumulate(InputIterator first, InputIterator last, T init); // (1)

  template <class InputIterator, class T, class BinaryOperation>
  T accumulate(InputIterator first, InputIterator last, T init,
               BinaryOperation binary_op);                       // (2)
}
```

## 概要
`accumulate()`は、範囲を集計する関数である。

初期値(`init`)に対して、範囲`[first, last)`の各要素`i`を前から順番に、任意の二項演算関数`binary_op`を`init = f(init, *i)`のように適用していき、範囲の全ての要素を集計した結果を戻り値として返す。

他の言語でこのような処理は、`foldL` (Haskell)、`reduce` (Common Lisp, Ruby)、`aggregate` (C#)などと呼ばれている。

- (1) : 二項演算をデフォルトで`operator+`とする。それによって、このオーバーロードは、範囲の合計値を求める処理となる
- (2) : 任意の二項演算関数を受け取って集計処理を行う


## 要件
- `T`が[CopyConstructible](/reference/concepts/CopyConstructible.md)であること
- `T`が[CopyAssignable](/reference/concepts/CopyAssignable.md)であること
- C++03まで : `binary_op`は副作用を起こしてはならない
- C++11から : `binary_op`は、範囲`[first, last)`の要素変更およびイテレータの無効化をしてはならない


## 効果
- (1) : `binary_op`を`operator+`として (2) の効果を適用する
- (2) : `acc = init`、`[first, last)`の各イテレータを`i`とし、`acc = binary_op(acc, *i)`を範囲の全要素に対して適用し、その結果となる`acc`を返す


## 戻り値
集計結果の値


## 計算量
範囲`[first, last)`の要素数に対して線形時間


## 例
```cpp example
#include <iostream>
#include <vector>
#include <string>
#include <numeric>

int main()
{
  const std::vector<int> v = {1, 2, 3, 4, 5};
  const std::vector<std::string> v2 = {"aaa", "bbb", "ccc"};

  // (1) : 合計値を求める
  int sum = std::accumulate(v.begin(), v.end(), 0);
  std::cout << "sum : " << sum << std::endl;

  // (1) : 合計値をlong long型として求める
  // accumulateの第3引数がlong long型のゼロを表す0LLになっていることに注意
  // accumulateの戻り値型は、第3引数の型となるため、変数sum_llの型はlong long
  auto sum_ll = std::accumulate(v.begin(), v.end(), 0LL);
  std::cout << "sum_ll : " << sum_ll << std::endl;

  // (1) : 文字列のリストを連結する
  std::string concatenate = std::accumulate(v2.begin(), v2.end(), std::string());
  std::cout << "concat : " << concatenate << std::endl;

  // (2) : 任意の二項演算を行う
  // ここでは、初期値を1として、全ての要素を掛け合わせている
  int product = std::accumulate(v.begin(), v.end(), 1, [](int init, int i) {
    return init * i;
  });
  std::cout << "product : " << product << std::endl;
}
```
* std::accumulate[color ff0000]

### 出力
```
sum : 15
sum_ll : 15
concat : aaabbbccc
product : 120
```


## 実装例
```cpp
// (1)
template <class InputIterator, class T>
T accumulate(InputIterator first, InputIterator last, T init) {
  while (first != last)
    init = init + *first++;
  return init;
}

// (2)
template <class InputIterator, class T, class BinaryOperation>
T accumulate(InputIterator first, InputIterator last, T init,
             BinaryOperation binary_op) {
  while (first != last)
    init = binary_op(init, *first++);
  return init;
}
```

