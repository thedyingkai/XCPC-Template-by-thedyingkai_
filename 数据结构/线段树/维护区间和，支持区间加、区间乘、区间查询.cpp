#include <template/start.cpp>

template <class T, class Ele> struct SegTree {
    T n;
    int mod;
    struct TreeNode {
        Ele sum, lazy[2];
        T l, r;
        friend TreeNode operator+(const TreeNode& A, const TreeNode& B) {
            TreeNode C;
            C.l = A.l;
            C.r = B.r;
            C.lazy[0] = 0;
            C.lazy[1] = 1;
            C.sum = (A.sum + B.sum) % mod;
            return C;
        }
    };
    vector<TreeNode> tree;
    SegTree(T N, const vector<Ele>& a, const int Mod) : n(N) {
        mod = Mod;
        tree.resize(4 * N);
        build(1, 1, n, a);
    }
    void initLazy(T root) {
        tree[root].lazy[0] = 0;
        tree[root].lazy[1] = 1;
    }
    void unionLazy(T fa, T ch) {
        tree[ch].lazy[0] = (tree[ch].lazy[0] * tree[fa].lazy[1] % mod + tree[fa].lazy[0]) % mod;
        tree[ch].lazy[0] %= mod;
        tree[ch].lazy[1] *= tree[fa].lazy[1];
        tree[ch].lazy[1] %= mod;
    }
    void calLazy(T root) {
        tree[root].sum *= tree[root].lazy[1];
        tree[root].sum %= mod;
        tree[root].sum += tree[root].lazy[0] * ((tree[root].r - tree[root].l + 1 + mod) % mod) % mod;
        tree[root].sum %= mod;
    }
    void pushDown(T root) {
        if(tree[root].lazy[0] != 0 || tree[root].lazy[1] != 1) {
            calLazy(root);
            if(tree[root].l != tree[root].r) {
                T ch = root << 1;
                unionLazy(root, ch);
                unionLazy(root, ch + 1);
            }
            initLazy(root);
        }
    }
    void update(T root) {
        T ch = root << 1;
        pushDown(ch);
        pushDown(ch + 1);
        tree[root] = tree[ch] + tree[ch + 1];
    }
    void build(T root, T l, T r, const vector<Ele>& a) {
        tree[root].l = l;
        tree[root].r = r;
        initLazy(root);
        if(l != r) {
            T mid = l + r >> 1;
            T ch = root << 1;
            build(ch, l, mid, a);
            build(ch + 1, mid + 1, r, a);
            update(root);
        } else {
            tree[root].sum = a[l];
        }
    }
    void update(T root, T l, T r, Ele val, int op) {
        pushDown(root);
        if(l == tree[root].l && r == tree[root].r) {
            if(op == 1) {
                tree[root].lazy[0] *= val;
                tree[root].lazy[0] %= mod;
                tree[root].lazy[1] *= val;
                tree[root].lazy[1] %= mod;
            }
            if(op == 2) {
                tree[root].lazy[0] += val;
                tree[root].lazy[0] %= mod;
            }
            return;
        }
        T mid = tree[root].l + tree[root].r >> 1;
        T ch = root << 1;
        if(r <= mid)
            update(ch, l, r, val, op);
        else if(l > mid)
            update(ch + 1, l, r, val, op);
        else {
            update(ch, l, mid, val, op);
            update(ch + 1, mid + 1, r, val, op);
        }
        update(root);
    }
    TreeNode query(T root, T l, T r) {
        pushDown(root);
        if(l == tree[root].l && r == tree[root].r) return tree[root];
        T mid = tree[root].l + tree[root].r >> 1;
        T ch = root << 1;
        if(r <= mid)
            return query(ch, l, r);
        else if(l > mid)
            return query(ch + 1, l, r);
        else
            return query(ch, l, mid) + query(ch + 1, mid + 1, r);
    }
    Ele query(T l, T r) { return query(1, l, r).sum; }
};

void solve() {
    int n, q, m;
    cin >> n >> q >> m;
    vector<i64> a(n + 1);
    for(int i = 1; i <= n; i++) {
        cin >> a[i];
        a[i] %= m;
    }

    SegTree<int, i64> st(n, a, m);
    while(q--) {
        int op, x, y;
        cin >> op >> x >> y;
        if(op != 3) {
            i64 k;
            cin >> k;
            k %= m;
            st.update(1, x, y, k, op);
        } else
            cout << st.query(x, y) << endl;
    }
}

int main() {
    auto begin = chrono::high_resolution_clock::now();
    ios::sync_with_stdio(0);
    cin.tie(0);
    solve();
    auto end = chrono::high_resolution_clock::now();
    auto elapsed = chrono::duration_cast<chrono::nanoseconds>(end - begin);
    cerr << "Time measured: " << elapsed.count() * 1e-9 << " seconds.\n";
}
