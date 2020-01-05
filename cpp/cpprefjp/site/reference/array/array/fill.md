# fill
* array[meta header]
* std[meta namespace]
* array[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
void fill(const T& u);
```

## 概要
コンテナを指定された値で埋める


## 効果
[`fill_n`](/reference/algorithm/fill_n.md)`(`[`begin`](begin.md)`(), N, u)`


## 戻り値
なし


## 例
```cpp example
#include <iostream>
#include <array>
#include <algorithm>

int main()
{
  std::array<int, 3> ar;

  ar.fill(3);

  std::for_each(ar.begin(), ar.end(), [](int x) {
    std::cout << x << std::endl;
  });
}
```
* fill[color ff0000]


### 出力
```
3
3
3
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2010, 2012


## 参照
- [LWG Issue 776. Undescribed `assign` function of `std::array`](http://www.open-std.org/jtc1/sc22/wg21/docs/lwg-defects.html#776)
    - `assign()`という名前だったメンバ関数が`fill()`に改名された経緯のレポート

