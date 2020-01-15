# back
* queue[meta header]
* std[meta namespace]
* queue[meta class]
* function[meta id-type]

```cpp
value_type& back();
const value_type& back() const;
```

## 概要
`queue` の最後の要素への参照を返す。

これは最後に `queue` に挿入された要素である。

内部のコンテナの `back()` メンバ関数を呼ぶ。


## 戻り値
`queue` の最後の要素への参照を返す。

`value_type` 型は内部のコンテナの値を表す型で、第１テンプレート引数の `T` と同じ型であるべきである。


## 例
```cpp example
#include <iostream>
#include <queue>

int main() {
  std::queue<int> que;

  que.push(10);
  std::cout << que.back() << std::endl; // 最後に挿入したのは10

  que.push(20);
  std::cout << que.back() << std::endl; // 最後に挿入したのは20

  que.push(30);
  std::cout << que.back() << std::endl; // 最後に挿入したのは30

  return 0;
}
```
* back()[color ff0000]
* q.push[link push.md]

### 出力
```
10
20
30
```

## 実装例
```cpp
value_type& back() { return c.back(); }
const value_type& back() const { return c.back(); }
```


