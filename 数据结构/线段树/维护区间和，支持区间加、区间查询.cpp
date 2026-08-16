#include "../../template/start.cpp"

template <class T, class Ele> struct SegTree {
    T n;
    struct TreeNode {
        Ele sum, lazy;
        T l, r;
        friend TreeNode operator+(const TreeNode& A, const TreeNode& B) {
            TreeNode C;
            C.l = A.l;
            C.r = B.r;
            C.lazy = 0;
            C.sum = A.sum + B.sum;
            return C;
        }
    };
    vector<TreeNode> tree;
    SegTree(T N, const vector<Ele>& a) : n(N) {
        tree.resize(4 * N);
        build(1, 1, n, a);
    }
    void initLazy(T root) { tree[root].lazy = 0; }
    void unionLazy(T fa, T ch) { tree[ch].lazy += tree[fa].lazy; }
    void calLazy(T root) { tree[root].sum += tree[root].lazy * (tree[root].r - tree[root].l + 1); }
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
    void build(T root, T l, T r, const vector<Ele>& a) {
        tree[root].l = l;
        tree[root].r = r;
        initLazy(root);
        if(l != r) {
            T mid = (l + r) >> 1;
            T ch = root << 1;
            build(ch, l, mid, a);
            build(ch + 1, mid + 1, r, a);
            update(root);
        } else {
            tree[root].sum = a[l];
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
    Ele query(T l, T r) { return query(1, l, r).sum; }
};
int main() {
    int n, m;
    cin >> n >> m;
    vector<i64> a(n + 1);
    for(int i = 1; i <= n; i++) cin >> a[i];
    SegTree<int, i64> st(n, a);
    while(m--) {
        int op, x, y;
        cin >> op >> x >> y;
        if(op == 1) {
            i64 k;
            cin >> k;
            st.update(1, x, y, k);
        } else
            cout << st.query(x, y) << endl;
    }
    return 0;
}
