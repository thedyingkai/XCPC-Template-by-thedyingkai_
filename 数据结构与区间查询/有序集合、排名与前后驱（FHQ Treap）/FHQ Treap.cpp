#include "../../template/start.cpp"

struct FHQTreap {
    struct Node {
        int ls, rs, sz;
        unsigned pri;
        i64 val;
    };
    int root;
    mt19937 rng;
    vector<Node> tree;
    FHQTreap() : root(0), rng(chrono::steady_clock::now().time_since_epoch().count()), tree(1) {}
    int size(int u) const { return u ? tree[u].sz : 0; }
    void pushup(int u) { tree[u].sz = size(tree[u].ls) + size(tree[u].rs) + 1; }
    int newNode(i64 val) {
        tree.push_back({0, 0, 1, rng(), val});
        return (int) tree.size() - 1;
    }
    void splitLess(int u, i64 val, int& x, int& y) {
        if(!u) {
            x = y = 0;
            return;
        }
        if(tree[u].val < val) {
            x = u;
            splitLess(tree[u].rs, val, tree[u].rs, y);
            pushup(x);
        } else {
            y = u;
            splitLess(tree[u].ls, val, x, tree[u].ls);
            pushup(y);
        }
    }
    void splitLE(int u, i64 val, int& x, int& y) {
        if(!u) {
            x = y = 0;
            return;
        }
        if(tree[u].val <= val) {
            x = u;
            splitLE(tree[u].rs, val, tree[u].rs, y);
            pushup(x);
        } else {
            y = u;
            splitLE(tree[u].ls, val, x, tree[u].ls);
            pushup(y);
        }
    }
    int merge(int x, int y) {
        if(!x || !y) return x | y;
        if(tree[x].pri < tree[y].pri) {
            tree[x].rs = merge(tree[x].rs, y);
            pushup(x);
            return x;
        } else {
            tree[y].ls = merge(x, tree[y].ls);
            pushup(y);
            return y;
        }
    }
    void insert(i64 val) {
        int x, y;
        splitLess(root, val, x, y);
        root = merge(merge(x, newNode(val)), y);
    }
    bool erase(i64 val) {
        int x, y, z;
        splitLess(root, val, x, y);
        splitLE(y, val, z, y);
        bool ok = z != 0;
        if(z) z = merge(tree[z].ls, tree[z].rs);
        root = merge(x, merge(z, y));
        return ok;
    }
    int countLess(i64 val) const {
        int u = root, ans = 0;
        while(u) {
            if(tree[u].val < val)
                ans += size(tree[u].ls) + 1, u = tree[u].rs;
            else
                u = tree[u].ls;
        }
        return ans;
    }
    int countLE(i64 val) const {
        int u = root, ans = 0;
        while(u) {
            if(tree[u].val <= val)
                ans += size(tree[u].ls) + 1, u = tree[u].rs;
            else
                u = tree[u].ls;
        }
        return ans;
    }
    int rank(i64 val) const { return countLess(val) + 1; }
    int count(i64 val) const { return countLE(val) - countLess(val); }
    optional<i64> kth(int k) const {
        if(k < 1 || k > size(root)) return nullopt;
        int u = root;
        while(u) {
            int left = size(tree[u].ls);
            if(k == left + 1) return tree[u].val;
            if(k <= left)
                u = tree[u].ls;
            else
                k -= left + 1, u = tree[u].rs;
        }
        return nullopt;
    }
    optional<i64> predecessor(i64 val) const {
        int u = root;
        optional<i64> ans;
        while(u) {
            if(tree[u].val < val)
                ans = tree[u].val, u = tree[u].rs;
            else
                u = tree[u].ls;
        }
        return ans;
    }
    optional<i64> successor(i64 val) const {
        int u = root;
        optional<i64> ans;
        while(u) {
            if(tree[u].val > val)
                ans = tree[u].val, u = tree[u].ls;
            else
                u = tree[u].rs;
        }
        return ans;
    }
};
