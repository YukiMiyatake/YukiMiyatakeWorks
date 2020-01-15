# swap (非メンバ関数)
* valarray[meta header]
* std[meta namespace]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class T>
  void swap(valarray<T>& x, valarray<T>& y) noexcept;
}
```

## 概要
2つの`valarray`オブジェクトを入れ替える。


## 効果
`x.`[`swap`](swap.md)`(y)`


## 計算量
定数時間


## 例
```cpp example
#include <iostream>
#include <valarray>

template <class T>
void print(const char* name, const std::valarray<T>& va)
{
  std::cout << name << " : {";
  bool first = true;

  for (const T& x : va) {
    if (first) {
      first = false;
    }
    else {
      std::cout << ',';
    }
    std::cout << x;
  }
  std::cout << "}" << std::endl;
}

int main()
{
  std::valarray<int> a = {1, 2, 3};
  std::valarray<int> b = {4, 5, 6};

  std::swap(a, b);

  print("a", a);
  print("b", b);
}
```
* std::swap[color ff0000]

### 出力
```
a : {4,5,6}
b : {1,2,3}
```


## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): 3.0
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.3
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


