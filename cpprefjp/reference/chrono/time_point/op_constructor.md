# コンストラクタ
* chrono[meta header]
* std::chrono[meta namespace]
* time_point[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
time_point();           // (1) C++11
constexpr time_point(); // (1) C++14

explicit time_point(const duration& d);           // (2) C++11
constexpr explicit time_point(const duration& d); // (2) C++14

template <class Duration2>
time_point(const time_point<clock, Duration2>& t);           // (3) C++14

template <class Duration2>
constexpr time_point(const time_point<clock, Duration2>& t); // (3) C++14
```

## time_pointの構築
- (1) : デフォルトコンストラクタ。エポックの`time_point(duration::zero())`を生成する。
- (2) : エポックからの経過時間から`time_point`を生成する。
- (3) : 他のテンプレートパラメータを持つ`time_point`からの変換コンストラクタ。


## 例
```cpp example
#include <iostream>
#include <chrono>

using namespace std::chrono;

int main()
{
  {
    time_point<system_clock> p; // エポック
    std::cout << p.time_since_epoch().count() << std::endl;
  }
  {
    time_point<system_clock> p(seconds(3)); // エポックから3秒後
    std::cout << p.time_since_epoch().count() << std::endl;
  }
  {
    time_point<system_clock, seconds> s(seconds(5)); // エポックから5秒後
    time_point<system_clock, milliseconds> m = s;    // 他のtime_pointに変換
    std::cout << m.time_since_epoch().count() << std::endl;
  }
}
```
* system_clock[link /reference/chrono/system_clock.md]
* time_since_epoch()[link time_since_epoch.md]
* count()[link /reference/chrono/duration/count.md]
* seconds[link /reference/chrono/seconds.md]
* milliseconds[link /reference/chrono/milliseconds.md]

### 出力
```
0
3000000
5000
```

## バージョン
### 言語
- C++11

### 処理系
- [GCC, C++11 mode](/implementation.md#gcc): 4.6.1
- [Visual C++](/implementation.md#visual_cpp): 2012, 2013, 2015

## 参照
- [N3469 Constexpr Library Additions: chrono, v3](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3469.html)

