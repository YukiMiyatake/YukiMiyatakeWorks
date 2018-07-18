# atan2
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> atan2(const valarray<T>& ys, const valarray<T>& xs); // (1)

  template <class T>
  valarray<T> atan2(const valarray<T>& ys, const T& x);            // (2)

  template <class T>
  valarray<T> atan2(const T& y, const valarray<T>& xs);            // (3)
}
```

## 概要
逆正接（アークタンジェント：arc tangent）を対辺と隣辺から求める。


## 戻り値
- (1) : 以下のコードと同等のことを行う：

```cpp
std::valarray<T> result(ys.size());
for (std::size_t i = 0; i < result.size(); ++i) {
  result[i] = std::atan2(ys[i], xs[i]);
}
return result;
```
* size()[link size.md]
* std::atan2[link /reference/cmath/atan2.md]


- (2) : 以下のコードと同等のことを行う：

```cpp
std::valarray<T> result(ys.size());
for (std::size_t i = 0; i < result.size(); ++i) {
  result[i] = std::atan2(ys[i], x);
}
return result;
```
* size()[link size.md]
* std::atan2[link /reference/cmath/atan2.md]


- (3) : 以下のコードと同等のことを行う：

```cpp
std::valarray<T> result(xs.size());
for (std::size_t i = 0; i < result.size(); ++i) {
  result[i] = std::atan2(y, xs[i]);
}
return result;
```
* size()[link size.md]
* std::atan2[link /reference/cmath/atan2.md]


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
  const std::valarray<float> ys = {0.1f, 0.2f, 0.3f};
  const std::valarray<float> xs = {0.3f, 0.2f, 0.1f};

  std::valarray<float> result1 = std::atan2(ys, xs);
  print("valarray-valarray", result1);

  std::valarray<float> result2 = std::atan2(ys, 0.3f);
  print("valarray-float", result2);

  std::valarray<float> result3 = std::atan2(0.1f, xs);
  print("float-valarray", result3);
}
```
* std::atan2[color ff0000]

### 出力
```
valarray-valarray : {0.321751,0.785398,1.24905}
valarray-float : {0.321751,0.588003,0.785398}
float-valarray : {0.321751,0.463648,0.785398}
```


