# operator++
* iterator[meta header]
* std[meta namespace]
* reverse_iterator[meta class]
* function[meta id-type]

```cpp
reverse_iterator& operator++();
reverse_iterator operator++(int);
```

## 概要
イテレータをインクリメントする。
`reverse_iterator`なので逆方向に進める。


## 効果

- 前置インクリメント `operator++()`：

```cpp
--current;
return *this;
```

- 後置インクリメント `operator++(int)`：

```cpp
reverse_iterator tmp = *this;
--current;
return tmp;
```


## 例
```cpp example
#include <iostream>
#include <vector>
#include <iterator>

int main()
{
  std::vector<int> v = {1, 2, 3};

  std::reverse_iterator<decltype(v)::iterator> it(v.end());

  ++it;

  std::cout << *it << std::endl;
}
```
* ++it[color ff0000]

### 出力
```
2
```

## 参照


