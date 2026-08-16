#include "../../template/start.cpp"

template <class T, class Ele> struct SegTree {
    const int Min = 0;
    T n;
    struct TreeNode {
        Ele Max, lazy;
        T l, r;
        friend TreeNode operator+(const TreeNode& A, const TreeNode& B) {
            TreeNode C;
            C.l = A.l;
            C.r = B.r;
            C.lazy = 0;
            C.Max = max(A.Max, B.Max);
            return C;
        }
    };
    vector<TreeNode> tree;
    SegTree(T N) : n(N) {
        tree.resize(4 * N);
        build(1, 1, n);
    }
    void initLazy(T root) { tree[root].lazy = 0; }
    void unionLazy(T fa, T ch) { tree[ch].lazy += tree[fa].lazy; }
    void calLazy(T root) { tree[root].Max += tree[root].lazy; }
    void pushDown(T root) {
        if(tree[root].lazy != 0) {
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
    void build(T root, T l, T r) {
        tree[root].l = l;
        tree[root].r = r;
        initLazy(root);
        if(l != r) {
            T mid = (l + r) >> 1;
            T ch = root << 1;
            build(ch, l, mid);
            build(ch + 1, mid + 1, r);
            update(root);
        } else {
            tree[root].Max = Min;
        }
    }
    void update(T root, T l, T r, Ele val) {
        pushDown(root);
        if(l == tree[root].l && r == tree[root].r) {
            tree[root].lazy += val;
            return;
        }
        T mid = (tree[root].l + tree[root].r) >> 1;
        T ch = root << 1;
        if(r <= mid)
            update(ch, l, r, val);
        else if(l > mid)
            update(ch + 1, l, r, val);
        else {
            update(ch, l, mid, val);
            update(ch + 1, mid + 1, r, val);
        }
        update(root);
    }
    TreeNode query(T root, T l, T r) {
        pushDown(root);
        if(l == tree[root].l && r == tree[root].r) return tree[root];
        T mid = (tree[root].l + tree[root].r) >> 1;
        T ch = root << 1;
        if(r <= mid)
            return query(ch, l, r);
        else if(l > mid)
            return query(ch + 1, l, r);
        else
            return query(ch, l, mid) + query(ch + 1, mid + 1, r);
    }
    Ele query(T l, T r) { return query(1, l, r).Max; }
};

void solve() {
    int n;
    cin >> n;
    vector<int> v(n + 1), a(n + 1), b(n + 1), n_b(n + 1);
    for(int i = 1; i <= n; i++) cin >> v[i];
    for(int i = 1; i <= n; i++) cin >> a[i];
    for(int i = 1; i <= n; i++) cin >> b[i], n_b[b[i]] = i;

    SegTree<int, i64> st(n + 1);

    vector<int> pos(n + 1);
    for(int i = 1; i <= n; i++) pos[i] = n_b[a[i]];

    for(int i = 1; i <= n; i++) {
        i64 cur = st.query(1, pos[i]), tem = st.query(pos[i] + 1, pos[i] + 1);
        if(tem < cur) st.update(1, pos[i] + 1, pos[i] + 1, cur - tem);
        st.update(1, 1, pos[i], v[a[i]]);
    }

    cout << st.query(1, n + 1) << "\n";
}

int main() {
    ios::sync_with_stdio(0);
    cin.tie(0);
    int T;
    cin >> T;
    while(T--) { solve(); }
    return 0;
}
