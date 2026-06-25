#include <template/start.cpp>

template <class Ele> struct BitTree {
    int n;
    vector<Ele> tree;
    BitTree(int N) : n(N) { tree.resize(N + 1); }
    int lowbit(int x) { return x & -x; }
    Ele query(int x) {
        Ele res = 0;
        while(x) {
            res += tree[x];
            x -= lowbit(x);
        }
        return res;
    }
    void update(int x, Ele k) {
        while(x <= n) {
            tree[x] += k;
            x += lowbit(x);
        }
    }
    void clear() { fill(tree.begin(), tree.end(), 0); }
};
struct CantorExpansion {
    static const i64 MOD = 998244353;
    int maxn;
    vector<i64> fact;
    BitTree<i64> bt;
    void init_factorial(int n) {
        fact.resize(n + 1);
        fact[0] = 1;
        for(int i = 1; i <= n; i++) fact[i] = (fact[i - 1] * i) % MOD;
    }
    CantorExpansion(int max_n) : maxn(max_n), bt(max_n) { init_factorial(max_n); }
    i64 encode(const vector<int>& perm) {
        int n = perm.size();
        bt.clear();
        for(int i = 1; i <= n; i++) bt.update(i, 1);
        i64 result = 0;
        for(int i = 0; i < n; i++) {
            i64 smaller = bt.query(perm[i] - 1);
            result = (result + (smaller * fact[n - 1 - i]) % MOD) % MOD;
            bt.update(perm[i], -1);
        }
        return (result + 1) % MOD;
    }
    vector<int> decode(i64 rank, int n) {
        rank = (rank - 1 + MOD) % MOD;
        vector<int> result;
        vector<bool> used(n + 1, false);
        for(int i = 0; i < n; i++) {
            i64 cnt = rank / fact[n - 1 - i];
            rank %= fact[n - 1 - i];
            int pos = 0;
            for(int j = 1; j <= n; j++)
                if(!used[j]) {
                    if(pos == cnt) {
                        result.push_back(j);
                        used[j] = true;
                        break;
                    }
                    pos++;
                }
        }
        return result;
    }
    i64 factorial(int n) { return fact[n]; }
    static i64 get_mod() { return MOD; }
};
