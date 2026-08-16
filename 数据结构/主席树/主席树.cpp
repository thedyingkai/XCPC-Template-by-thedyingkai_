#include "../../template/start.cpp"

template <class T> struct ChairmanTree {
    struct Node {
        int ls, rs, sum;
    };
    int n, m;
    vector<T> val;
    vector<int> root;
    vector<Node> tree;
    ChairmanTree(const vector<T>& a) {
        n = (int) a.size() - 1;
        val.assign(a.begin() + 1, a.end());
        sort(val.begin(), val.end());
        val.erase(unique(val.begin(), val.end()), val.end());
        m = val.size();
        int lg = 1;
        while((1LL << lg) <= max(1, m)) lg++;
        tree.reserve((size_t) (n + 1) * (lg + 1));
        tree.push_back({});
        root.resize(n + 1);
        for(int i = 1; i <= n; i++) {
            int x = lower_bound(val.begin(), val.end(), a[i]) - val.begin() + 1;
            root[i] = insert(root[i - 1], 1, m, x);
        }
    }
    int insert(int pre, int l, int r, int x) {
        int u = tree.size();
        tree.push_back(tree[pre]);
        tree[u].sum++;
        if(l == r) return u;
        int mid = (l + r) >> 1;
        if(x <= mid)
            tree[u].ls = insert(tree[pre].ls, l, mid, x);
        else
            tree[u].rs = insert(tree[pre].rs, mid + 1, r, x);
        return u;
    }
    int query(int u, int v, int l, int r, int ql, int qr) const {
        if(ql <= l && r <= qr) return tree[v].sum - tree[u].sum;
        int mid = (l + r) >> 1, ans = 0;
        if(ql <= mid) ans += query(tree[u].ls, tree[v].ls, l, mid, ql, qr);
        if(qr > mid) ans += query(tree[u].rs, tree[v].rs, mid + 1, r, ql, qr);
        return ans;
    }
    T kth(int l, int r, int k) const {
        assert(1 <= l && l <= r && r <= n && 1 <= k && k <= r - l + 1);
        int u = root[l - 1], v = root[r], ql = 1, qr = m;
        while(ql < qr) {
            int cnt = tree[tree[v].ls].sum - tree[tree[u].ls].sum;
            int mid = (ql + qr) >> 1;
            if(k <= cnt)
                u = tree[u].ls, v = tree[v].ls, qr = mid;
            else
                k -= cnt, u = tree[u].rs, v = tree[v].rs, ql = mid + 1;
        }
        return val[ql - 1];
    }
    int count(int l, int r, const T& low, const T& high) const {
        assert(1 <= l && l <= r && r <= n);
        int ql = lower_bound(val.begin(), val.end(), low) - val.begin() + 1;
        int qr = upper_bound(val.begin(), val.end(), high) - val.begin();
        if(ql > qr) return 0;
        return query(root[l - 1], root[r], 1, m, ql, qr);
    }
};
