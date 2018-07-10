# コンストラクタ
* iterator[meta header]
* std[meta namespace]
* ostreambuf_iterator[meta class]
* function[meta id-type]

```cpp
ostreambuf_iterator(ostream_type& s) noexcept;
ostreambuf_iterator(streambuf_type* s) noexcept;
```

## ostreambuf_iteratorオブジェクトの構築
- `ostreambuf_iterator(ostreamtype& s) noexcept`

`s.rdbuf()`をメンバ変数として保持する。

- `ostreambuf_iterator(streambuf_type* s) noexcept`

`s`をメンバ変数として保持する


## 例
```cpp example
#include <iostream>
#include <iterator>
#include <algorithm>
#include <string>

int main()
{
  const std::string s = "Hello";

  // ストリームの参照から構築
  std::ostreambuf_iterator<char> it1(std::cout);

  // streambuf*から構築
  std::ostreambuf_iterator<char> it2(std::cout.rdbuf());

  std::copy(s.begin(), s.end(), it1);
  std::copy(s.begin(), s.end(), it2);
}
```
* rdbuf()[link /reference/ios/basic_ios/rdbuf.md]

### 出力
```
HelloHello
```

## 参照


