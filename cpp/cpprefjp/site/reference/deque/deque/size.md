# size
* deque[meta header]
* std[meta namespace]
* deque[meta class]
* function[meta id-type]

```cpp
size_type size() const noexcept;
```

## 概要
コンテナの要素数を取得する。


## 戻り値
`deque`オブジェクトに含まれる要素数を返す。


## 例外
投げない


## 計算量
定数時間


## 例
```cpp example
#include <iostream>
#include <deque>

int main()
{
  std::deque<int> c = {3, 1, 4, 5, 2};

  std::size_t size = c.size();
  std::cout << size << std::endl;
}
```
* size()[color ff0000]

### 出力
```
5
```

## 関連項目

| 名前 | 説明 |
|-----------------------------|----------------------------------|
| [`resize`](resize.md)     | 要素数を変更する |
| [`max_size`](max_size.md) | 格納可能な最大の要素数を取得する |


