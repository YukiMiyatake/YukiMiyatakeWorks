# acos
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function template[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> acos(const valarray<T>& va);
}
```

## 概要
逆余弦（アークコサイン：arc cosine）を得る。


## 戻り値
以下のコードと同等のことを行う：

```cpp
return va.apply(static_cast<T(*)(T)>(std::acos));
```
* apply[link apply.md]
* std::acos[link /reference/cmath/acos.md]


## 例
```cpp example
#include <iostream>
#include <valarray>

int main()
{
  const std::valarray<float> va = {0.1f, 0.2f, 0.3f};

  std::valarray<float> result = std::acos(va);
  for (float x : result) {
    std::cout << x << std::endl;
  }
}
```
* std::acos[color ff0000]

### 出力
```
1.47063
1.36944
1.2661
```


