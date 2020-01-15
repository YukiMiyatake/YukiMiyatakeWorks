# operator>=
* iterator[meta header]
* std[meta namespace]
* function[meta id-type]

```cpp
namespace std {
  template <class Iterator1, class Iterator2>
  bool operator>=(const reverse_iterator<Iterator1>& x,
                  const reverse_iterator<Iterator2>& y);
}
```

## 概要
2つの`reverse_iterator`オブジェクトにおいて、左辺が右辺以上かを判定する。


## 戻り値
`x.current <= y.current`


## 例
```cpp example
#include <iostream>
#include <vector>
#include <iterator>

int main()
{
  std::vector<int> v = {1, 2, 3};

  std::reverse_iterator<decltype(v)::iterator> it1(v.begin());
  std::reverse_iterator<decltype(v)::iterator> it2(v.begin() + 1);

  if (it1 >= it2) {
    std::cout << "greater" << std::endl;
  }
  else {
    std::cout << "not greater" << std::endl;
  }
}
```
* it1 >= it2[color ff0000]

### 出力
```
greater
```

## 参照


