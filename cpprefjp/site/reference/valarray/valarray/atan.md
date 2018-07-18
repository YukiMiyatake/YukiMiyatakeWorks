# atan
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> atan(const valarray<T>& va);
}
```

## 概要
逆正接（アークタンジェント：arc tangent）を得る。


## 戻り値
以下のコードと同等のことを行う：

```cpp
return va.apply(static_cast<T(*)(T)>(std::atan));
```
* apply[link apply.md]
* std::atan[link /reference/cmath/atan.md]


## 例
```cpp example
#include <iostream>
#include <valarray>

int main()
{
  const std::valarray<float> va = {0.1f, 0.2f, 0.3f};

  std::valarray<float> result = std::atan(va);
  for (float x : result) {
    std::cout << x << std::endl;
  }
}
```
* std::atan[color ff0000]

### 出力
```
0.0996687
0.197396
0.291457
```


