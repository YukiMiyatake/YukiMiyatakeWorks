# now
* chrono[meta header]
* std::chrono[meta namespace]
* high_resolution_clock[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
static time_point now() noexcept;
```
* time_point[link /reference/chrono/time_point.md]

## 概要
現在日時を取得する


## 戻り値
現在日時を指す[`time_point`](/reference/chrono/time_point.md)。


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <chrono>

using namespace std::chrono;

int main()
{
  high_resolution_clock::time_point p = high_resolution_clock::now();

  seconds d = duration_cast<seconds>(p.time_since_epoch());
  std::cout << d.count() << std::endl;
}
```
* high_resolution_clock::now()[color ff0000]
* duration_cast[link /reference/chrono/duration_cast.md]
* seconds[link /reference/chrono/seconds.md]
* time_since_epoch()[link /reference/chrono/time_point/time_since_epoch.md]
* count()[link /reference/chrono/duration/count.md]

### 出力例
```
1317184255
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.6.1
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013, 2015
