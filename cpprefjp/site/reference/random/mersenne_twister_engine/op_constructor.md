# コンストラクタ
* random[meta header]
* std[meta namespace]
* mersenne_twister_engine[meta class]
* function[meta id-type]
* cpp11[meta cpp]

```cpp
explicit mersenne_twister_engine(result_type value = default_seed);  // (1)
template<class Sseq> explicit mersenne_twister_engine(Sseq& q);      // (2)

mersenne_twister_engine(const mersenne_twister_engine& e) = default; // (3)
mersenne_twister_engine(mersenne_twister_engine&& e) = default;      // (4)
```

## 概要
- (1) : シード値を受け取って状態シーケンスを構築する。
    - シード値が指定されない場合はデフォルトのシード値 (`mersenne_twister_engine::default_seed`) で構築される
- (2) : シードのシーケンスを受け取って状態シーケンスを構築する。
- (3) : コピーコンストラクタ。状態シーケンスをコピーする。
- (4) : ムーブコンストラクタ。


## 計算量
- (1) : 状態のサイズ `n` (`mersenne_twister_engine::state_size`) に対し O(n)
- (4) : 状態シーケンスの要素数はコンパイル時に決定されるため、多くの場合状態シーケンスはスタック上(配列)に作られる。そのため、ムーブが効果的に動作することは期待できない


## 例
```cpp example
#include <iostream>
#include <random>
#include <array>

int main()
{
  // (1) デフォルト構築
  // デフォルトのシード値(default_seed静的データメンバ)から構築する
  {
    std::mt19937 engine;

    std::uint32_t result = engine();
    std::cout << result << std::endl;
  }

  // (1) シード値を指定して構築
  {
    std::uint32_t seed = std::random_device()();
    std::mt19937 engine(seed);

    std::uint32_t result = engine();
    std::cout << result << std::endl;
  }

  // (2) シードのシーケンスを指定して構築
  {
    // シードのシーケンスを作る
    std::random_device seed_gen;
    std::array<std::uint32_t, 100> seeds;

    for (std::uint32_t& x : seeds) {
      x = seed_gen();
    }

    std::seed_seq seq(seeds.begin(), seeds.end());

    // シードのシーケンスを指定してエンジンを初期化
    std::mt19937 engine(seq);

    std::uint32_t result = engine();
    std::cout << result << std::endl;
  }
}
```
* engine()[link op_call.md]
* std::uint32_t[link /reference/cstdint/uint32_t.md]
* std::seed_seq[link /reference/random/seed_seq.md]
* seeds.begin()[link /reference/array/begin.md]
* seeds.end()[link /reference/array/end.md]

### 出力例
```
3499211612
4275542254
2960779330
```

## バージョン
### 言語
- C++11

### 処理系
- [Clang](/implementation.md#clang): ??
- [GCC](/implementation.md#gcc): 
- [GCC, C++11 mode](/implementation.md#gcc): 4.7.2
- [ICC](/implementation.md#icc): ??
- [Visual C++](/implementation.md#visual_cpp): ??


## 参照


