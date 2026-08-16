#include "../../template/start.cpp"

i64 gcd(i64 a, i64 b) { return b == 0 ? abs(a) : gcd(b, a % b); }
struct Fenwick {
    vector<i64> bit;
    int n;
    Fenwick(int n) : n(n) { bit.assign(n + 1, 0); }
    void update(int i, i64 delta) {
        for(; i <= n; i += i & -i) bit[i] += delta;
    }
    i64 query(int i) {
        i64 sum = 0;
        for(; i > 0; i -= i & -i) sum += bit[i];
        return sum;
    }
    void range_add(int l, int r, i64 k) {
        update(l, k);
        if(r + 1 <= n) update(r + 1, -k);
    }
};
struct GcdSegmentTree {
    int n;
    vector<i64> tree;
    GcdSegmentTree(int size) : n(size), tree(4 * size, 0) {}
    void update(int root, int l, int r, int idx, i64 val) {
        if(l == r) {
            tree[root] = val;
            return;
        }
        int mid = (l + r) >> 1;
        if(idx <= mid)
            update(root << 1, l, mid, idx, val);
        else
            update(root << 1 | 1, mid + 1, r, idx, val);
        tree[root] = ::gcd(tree[root << 1], tree[root << 1 | 1]);
    }
    i64 query(int root, int l, int r, int ql, int qr) {
        if(ql > qr) return 0;
        if(ql <= l && r <= qr) return tree[root];
        int mid = (l + r) >> 1;
        i64 left_gcd = 0, right_gcd = 0;
        if(ql <= mid) left_gcd = query(root << 1, l, mid, ql, qr);
        if(qr > mid) right_gcd = query(root << 1 | 1, mid + 1, r, ql, qr);
        return ::gcd(left_gcd, right_gcd);
    }
    void update_point(int idx, i64 val) { update(1, 1, n, idx, val); }
    i64 query_range(int l, int r) { return query(1, 1, n, l, r); }
};

int main() {
    int n, m;
    cin >> n >> m;
    vector<i64> a(n + 1);
    for(int i = 1; i <= n; i++) cin >> a[i];
    Fenwick fenw(n);               // 树状数组：维护对 a 的增量（支持区间加）
    GcdSegmentTree segTree(n); // 线段树：维护差分数组 d 的 GCD（d[i] = a[i] - a[i-1]）
    for(int i = 2; i <= n; i++) {  // 初始化差分数组
        segTree.update_point(i, a[i] - a[i - 1]);
    }
    while(m--) {
        string op;
        cin >> op;
        if(op[0] == 'C') {
            int l, r; // 区间加：l, r, k
            i64 k;
            cin >> l >> r >> k;
            fenw.range_add(l, r, k); // 记录增量
            if(l >= 2) {             // 更新差分数组 d
                i64 new_dl = (a[l] + fenw.query(l)) - (a[l - 1] + fenw.query(l - 1));
                segTree.update_point(l, new_dl);
            }
            if(r + 1 <= n) {
                i64 new_dr1 = (a[r + 1] + fenw.query(r + 1)) - (a[r] + fenw.query(r));
                segTree.update_point(r + 1, new_dr1);
            }
        } else if(op[0] == 'Q') {
            int l, r; // 区间 GCD 查询：[l, r]
            cin >> l >> r;
            if(l == r)
                cout << abs(a[l] + fenw.query(l)) << '\n';
            else {
                i64 current_al = a[l] + fenw.query(l);        // 当前 a[l]
                i64 gcd_diff = segTree.query_range(l + 1, r); // gcd(d[l+1..r])
                cout << ::gcd(current_al, gcd_diff) << '\n';
            }
        }
    }
    return 0;
}
