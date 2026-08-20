`subsetZeta(a)` 把 `a[S]` 变为所有子集的和，第二参数为 `true` 时做子集 Möbius 逆变换；`supersetZeta` 对所有超集做同样操作。逐位决定是否加入该位，每一对状态只在对应位处理一次，因此复杂度为 $O(k 2^k)$。数组长度必须是二的幂，模数固定为 $998244353$。

OR 卷积先对子集做 zeta，AND 卷积先对超集做 zeta，逐点相乘后逆变换；XOR 卷积使用 Walsh--Hadamard 变换，逆变换每层乘 $2^(-1)$。数论中的莫比乌斯反演和这里的子集 Möbius 反演属于不同偏序。只枚举一个集合的全部非空子集可写 `for(T=S;T;T=(T-1)&S)`，所有 `S` 合计为 $O(3^k)$，规模小时往往比完整子集卷积更短。

#link("https://judge.yosupo.jp/problem/bitwise_and_convolution")[Library Checker · bitwise_and_convolution]

#link("https://judge.yosupo.jp/problem/bitwise_xor_convolution")[Library Checker · bitwise_xor_convolution]
