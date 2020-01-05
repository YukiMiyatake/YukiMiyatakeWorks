# operator<
* filesystem[meta header]
* std::filesystem[meta namespace]
* function[meta id-type]
* cpp17[meta cpp]

```cpp
namespace std::filesystem {
  bool operator<(const path& lhs, const path& rhs) noexcept;
}
```

## 概要
`path`クラスにおいて、左辺が右辺より小さいかの判定を行う。


## 戻り値
```cpp
return lhs.compare(rhs) < 0;
```
* compare[link compare.md]


## 例
```cpp example
#include <cassert>
#include <filesystem>

namespace fs = std::filesystem;

int main()
{
  fs::path a = "a/b/c";
  fs::path b = "a/b/d";

  assert(a < b);
}
```
* a < b[color ff0000]

### 出力
```
```

## バージョン
### 言語
- C++17

### 処理系
- [Clang](/implementation.md#clang):
- [GCC, C++17 mode](/implementation.md#gcc): 8.1
- [Visual C++](/implementation.md#visual_cpp):
