# operator/
* valarray[meta header]
* std[meta namespace]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> operator/(const valarray<T>& xs, const valarray<T>& ys); // (1)

  template <class T>
  valarray<T> operator/(const valarray<T>& xs, const T& y);            // (2)

  template <class T>
  valarray<T> operator/(const T& x, const valarray<T>& ys);            // (3)
}
```

## 概要
`valarray`において、左辺と右辺を除算する。

- (1) : `xs`の各要素と、`ys`の各要素を除算する。
- (2) : `xs`の各要素と、`y`を除算する。
- (3) : `x`と、`ys`の各要素を除算する。


## 戻り値
- (1) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result /= ys;
return result;
```
* /=[link op_divide_assign.md]


- (2) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result = xs;
result /= y;
return result;
```
* /=[link op_divide_assign.md]


- (3) : 以下のコードと同等のことを行う：

```cpp
valarray<T> result(ys.size());
for (std::size_t i = 0; i < result.size(); ++i) {
  result[i] = x / ys[i];
}
return result;
```
* size()[link size.md]


## 備考
2つの`valarray`オブジェクトの要素数が異なる場合、その挙動は未定義。


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
  const std::valarray<int> a = {4, 5, 6};
  const std::valarray<int> b = {1, 2, 3};

  std::valarray<int> result1 = a / b;
  print("valarray/valarray", result1);

  std::valarray<int> result2 = a / 2;
  print("valarray/int", result2);

  std::valarray<int> result3 = 15 / a;
  print("int/valarray", result3);
}
```

### 出力
```
valarray/valarray : {4,2,2}
valarray/int : {2,2,3}
int/valarray : {3,3,2}
```


