# swap (非メンバ関数)
* future[meta header]
* std[meta namespace]
* function template[meta id-type]
* cpp11[meta cpp]

```cpp
namespace std {
  template <class R>
  void swap(promise<R>& x, promise<R>& y) noexcept;
}
```

## 概要
2つの`promise`オブジェクトを入れ替える


## 効果
`x.`[`swap`](swap_free.md)`(y)`


## 戻り値
なし


## 例外
投げない


## 例
```cpp example
#include <iostream>
#include <future>

int main()
{
  std::promise<int> p1;
  std::promise<int> p2;

  std::future<int> f1 = p1.get_future();
  std::future<int> f2 = p2.get_future();

  // 共有状態を入れ替える
  std::swap(p1, p2);

  p1.set_value(1);
  p2.set_value(2);

  // p1に書き込んだ値はf2、
  // p2に書き込んだ値はf1から取得される
  std::cout << f1.get() << std::endl;
  std::cout << f2.get() << std::endl;
}
```
* std::swap[color ff0000]
* std::future[link /reference/future/future.md]
* get_future()[link get_future.md]
* set_value[link set_value.md]
* get()[link /reference/future/future/get.md]

### 出力
```
2
1
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.0
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): 2012


## 参照


