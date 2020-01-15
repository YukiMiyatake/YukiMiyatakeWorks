# is_symlink
* filesystem[meta header]
* std::filesystem[meta namespace]
* function[meta id-type]
* cpp17[meta cpp]

```cpp
namespace std::filesystem {
  bool is_symlink(file_status s) noexcept;                      // (1)
  bool is_symlink(const path& p);                               // (2)
  bool is_symlink(const path& p, std::error_code& ec) noexcept; // (3)
}
```
* file_status[link file_status.md]
* path[link path.md]

## 概要
指定されたパスがシンボリックリンクを指しているかを確認する。


## 戻り値
- (1) : `return` [`s.type()`](file_status/type.md) `==` [`file_type::symlink`](file_type.md)`;`
- (2) : `return is_symlink(`[`symlink_status`](symlink_status.md)`(p));`
- (3) :
    ```cpp
    file_status s = symlink_status(p, ec);
    if (ec) {
      return false;
    }

    // ファイルが見つからなかったらエラー
    file_type type = s.type();
    if (type == file_type::none || file_type::not_found || file_type::unknown) {
      ec = implementation-defined;
      return false;
    }
    ec.clear();
    return is_symlink(s);
    ```
    * file_status[link file_status.md]
    * symlink_status[link symlink_status.md]
    * file_type[link file_type.md]
    * s.type()[link file_status/type.md]
    * ec.clear()[link /reference/system_error/error_code/clear.md]


## 例外
- (1) : 投げない
- (2) : ファイルシステムがエラーを報告する場合がある。それに加えて、指定されたファイルの種別が[`file_type::none`](file_type.md)、[`file_type::not_found`](file_type.md)、[`file_type::unknown`](file_type.md)のいずれかである場合もエラーである。エラーが発生した場合は、[`std::filesystem::filesystem_error`](filesystem_error.md)例外を送出する
- (3) : 投げない


## 例
```cpp example
#include <cassert>
#include <fstream>
#include <filesystem>

namespace fs = std::filesystem;

int main()
{
  std::ofstream{"regular.txt"};
  fs::create_symlink("regular.txt", "regular.symlink");
  fs::create_directory("dir");

  // (1)
  // 取得済みのファイル状態を使用して、シンボリックリンクかを確認
  assert(fs::is_symlink(fs::symlink_status("regular.symlink")));

  // (2)
  // パスを指定して、シンボリックリンクかを確認。
  assert(fs::is_symlink("regular.symlink"));
  assert(!fs::is_symlink("regular.txt"));
  assert(!fs::is_symlink("dir"));

  // (3)
  // エラー情報を例外ではなくerror_codeで受け取る
  std::error_code ec;
  bool result = fs::is_symlink("regular.symlink", ec);
  assert(!ec);
  assert(result);
}
```
* fs::is_symlink[color ff0000]
* fs::create_symlink[link create_symlink.md]
* fs::create_directory[link create_directory.md]
* fs::symlink_status[link symlink_status.md]

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
