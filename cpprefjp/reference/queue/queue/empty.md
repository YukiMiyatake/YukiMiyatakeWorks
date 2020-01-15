# empty
* queue[meta header]
* std[meta namespace]
* queue[meta class]
* function[meta id-type]

```cpp
bool empty() const;
```

## 概要
`queue` が空か否か、つまり要素数が 0 か否かを判定する。
内部のコンテナの `empty()` メンバ関数を呼ぶ。


## 効果
```cpp
return c.empty()
```


## 戻り値
要素数が 0 の場合は `true`、それ以外の場合は `false` を返す。


## 計算量
定数時間 O(1)。


## 例
```cpp example
#include <iostream>
#include <queue>

int main() {
  std::queue<int> que;

  if (que.empty()) {
    std::cout << "empty" << std::endl;
  }
  else {
    std::cout << "not empty" << std::endl;
  }
  return 0;
}
```

### 出力
```
empty
```

## 参照


