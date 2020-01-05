# move
* string[meta header]
* std[meta namespace]
* char_traits[meta class]
* function[meta id-type]

```cpp
static char_type* move(char_type* s1, const char_type* s2, std::size_t n);
```

## 概要
文字列`s1`に文字列`s2`をコピーする。


## 効果
範囲`[0, n)`の各`i`について、[`assign`](assign.md)`(s1[i], s2[i])`を実行する。  
この関数は、範囲`[s1, s1+n)`と範囲`[s2, s2+n)`が重なっていても正しくコピーされる。


## 戻り値
コピー完了後の`s1`を返す。


## 計算量
線形時間


## 例
```cpp example
#include <iostream>
#include <string>

int main()
{
  const std::size_t n = 5 + 1;
  char s[n] = "abcde";

  {
    char result[n];
    std::char_traits<char>::move(result, s, n);

    std::cout << result << std::endl;
  }

  // 範囲が重なっていた場合でも正しくコピーされる
  {
    std::char_traits<char>::move(s, s, n);
    std::cout << s << std::endl;
  }
}
```
* move[color ff0000]

### 出力例
```
abcde
abcde
```

## 参照

