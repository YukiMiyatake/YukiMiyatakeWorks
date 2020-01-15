# sinh
* valarray[meta header]
* std[meta namespace]
* valarray[meta class]
* function[meta id-type]

```cpp
namespace std {
  template <class T>
  valarray<T> sinh(const valarray<T>& v);
}
```

## 概要
双曲線正弦（ハイパボリックサイン：hyperbolic sine）を得る。


## 戻り値
以下のコードと同等のことを行う：

```cpp
return v.apply(static_cast<T(*)(T)>(std::sinh));
```
* apply[link apply.md]
* std::sinh[link /reference/cmath/sinh.md]


## 例
```cpp example
#include <iostream>
#include <valarray>

int main()
{
  const std::valarray<float> va = {0.1f, 0.2f, 0.3f};

  std::valarray<float> result = std::sinh(va);
  for (float x : result) {
    std::cout << x << std::endl;
  }
}
```
* std::sinh[color ff0000]

### 出力
```
0.100167
0.201336
0.30452
```


