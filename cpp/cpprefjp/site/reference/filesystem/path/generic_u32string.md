# generic_u32string
* filesystem[meta header]
* std::filesystem[meta namespace]
* path[meta class]
* function[meta id-type]
* cpp17[meta cpp]

```cpp
std::u32string generic_u32string() const;
```

## 概要
UTF-32エンコードで、環境非依存パスフォーマットのパス文字列を取得する。


## 戻り値
`*this`が保持するシステムの環境非依存パスフォーマットを持つパスを、UTF-32エンコードで返す。


## 例
### POSIXベースシステムでの例
```cpp example
#include <iostream>
#include <filesystem>

namespace fs = std::filesystem;

int main()
{
  fs::path p = "/usr/bin/clang";
  const std::u32string s = p.generic_u32string();
}
```
* p.generic_u32string()[color ff0000]

#### 出力
```
```


### Windowsでの例
```cpp
#include <cassert>
#include <filesystem>

namespace fs = std::filesystem;

int main()
{
  fs::path p = "foo\\bar";
  const std::u32string s = p.generic_u32string();
  assert(s == U"foo/bar");
}
```
* p.generic_u32string()[color ff0000]

#### 出力
```
```

Windowsでの例は、Visual C++が正式にファイルシステムライブラリをサポートしていないことから、未検証のサンプルコード・出力となっている。


## バージョン
### 言語
- C++17

### 処理系
- [Clang](/implementation.md#clang):
- [GCC, C++17 mode](/implementation.md#gcc): 8.1
- [Visual C++](/implementation.md#visual_cpp):