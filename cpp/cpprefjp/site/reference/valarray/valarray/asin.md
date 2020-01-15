# asin
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function template[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> asin(const valarray<T>& va);
}
```

## 概要
逆正弦（アークサイン：arc sine）を得る。


## 戻り値
以下のコードと同等のことを行う：

```cpp
return va.apply(static_cast<T(*)(T)>(std::asin));
```
* apply[link apply.md]
* std::asin[link /reference/cmath/asin.md]


## 例
```cpp example
#include <iostream>
#include <valarray>

int main()
{
  const std::valarray<float> va = {0.1f, 0.2f, 0.3f};

  std::valarray<float> result = std::asin(va);
  for (float x : result) {
    std::cout << x << std::endl;
  }
}
```
* std::asin[color ff0000]

### 出力
```
0.0998334
0.198669
0.29552
```


