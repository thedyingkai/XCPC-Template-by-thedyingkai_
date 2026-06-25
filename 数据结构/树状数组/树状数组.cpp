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
};
bool isPow2(i64 x) { return x && x == (x & -x); }
template <class Ele> i64 countInv(int n, vector<Ele> a) {
    vector<Ele> b(a.begin() + 1, a.end());
    sort(b.begin(), b.end());
    b.erase(unique(b.begin(), b.end()), b.end());
    for(int i = 1; i <= n; i++) a[i] = (Ele) (lower_bound(b.begin(), b.end(), a[i]) - b.begin()) + 1;
    BitTree<i64> bt(b.size());
    i64 ans = 0;
    for(int i = 1; i <= n; i++) {
        ans += i - 1 - bt.query(a[i]);
        bt.update(a[i], 1);
    }
    return ans;
}
void main() {
    vector<i64> x = {0, 1, 2, 3, 4, 5, 8, 6, 7}; // 1-index
    cout << countInv<i64>(8, x);
}
