# operator!=
* iterator[meta header]
* std[meta namespace]
* function template[meta id-type]

```cpp
namespace std {
  template <class Iterator1, class Iterator2>
  bool operator!=(const reverse_iterator<Iterator1>& x,
                  const reverse_iterator<Iterator2>& y);
}
```

## 概要
2つの`reverse_iterator`オブジェクトが同じ要素を指していないかを判定する。


## 戻り値
`x.current != y.current`


## 例
```cpp example
#include <iostream>
#include <vector>
#include <iterator>

int main()
{
  std::vector<int> v = {1, 2, 3};

  std::reverse_iterator<decltype(v)::iterator> it1(v.end());
  std::reverse_iterator<decltype(v)::iterator> it2(v.begin());

  if (it1 != it2) {
    std::cout << "not equal" << std::endl;
  }
  else {
    std::cout << "equal" << std::endl;
  }
}
```
* it1 != it2[color ff0000]

### 出力
```
not equal
```

## 参照


