# time_since_epoch
* chrono[meta header]
* std::chrono[meta namespace]
* time_point[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
duration time_since_epoch() const;           // C++11
constexpr duration time_since_epoch() const; // C++14
```

## 概要
エポックからの経過時間を取得する


## 戻り値
エポックからの経過時間


## 例
```cpp example
#include <iostream>
#include <chrono>

using namespace std::chrono;

int main()
{
  system_clock::time_point p = system_clock::now(); // 現在日時を取得

  seconds s = duration_cast<seconds>(p.time_since_epoch()); // エポックからの経過時間(秒)を取得
  std::cout << s.count() << std::endl;
}
```
* time_since_epoch()[color ff0000]
* system_clock[link /reference/chrono/system_clock.md]
* now()[link /reference/chrono/system_clock/now.md]
* duration_cast[link /reference/chrono/duration_cast.md]
* seconds[link /reference/chrono/seconds.md]
* count()[link /reference/chrono/duration/count.md]

### 出力例
```
1314322091
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.5.1, 4.6.1
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013, 2015

## 参照
- [N3469 Constexpr Library Additions: chrono, v3](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3469.html)

