#pragma once
#include "../../template/start.cpp"

struct MergeableSegmentTree {
    struct Node { int left = 0, right = 0; i64 sum = 0; };
    int size;
    vector<Node> tree{Node{}};

    explicit MergeableSegmentTree(int size_) : size(size_) { assert(size >= 1); }

    int add(int u, int l, int r, int position, i64 delta) {
        if(!u) {
            tree.push_back({});
            u = (int) tree.size() - 1;
        }
        if(l == r) {
            assert((i128) tree[u].sum + delta >= 0);
            assert((i128) tree[u].sum + delta <= LLONG_MAX);
            tree[u].sum += delta;
            return u;
        }
        int mid = midpoint(l, r);
        // Do not keep references into vector across recursive allocations.
        if(position <= mid) {
            int child = add(tree[u].left, l, mid, position, delta);
            tree[u].left = child;
        } else {
            int child = add(tree[u].right, mid + 1, r, position, delta);
            tree[u].right = child;
        }
        pull(u);
        return u;
    }

    void pull(int u) {
        i128 value = (i128) tree[tree[u].left].sum + tree[tree[u].right].sum;
        assert(value <= LLONG_MAX);
        tree[u].sum = (i64) value;
    }

    int add(int root, int position, i64 delta) {
        assert(1 <= position && position <= size);
        return add(root, 1, size, position, delta);
    }

    // Destructive: invalidate BOTH old handles and retain only the result.
    int merge(int x, int y, int l, int r) {
        if(!x || !y) return x | y;
        assert(x != y);
        if(l == r) {
            assert((i128) tree[x].sum + tree[y].sum <= LLONG_MAX);
            tree[x].sum += tree[y].sum;
            return x;
        }
        int mid = midpoint(l, r);
        tree[x].left = merge(tree[x].left, tree[y].left, l, mid);
        tree[x].right = merge(tree[x].right, tree[y].right, mid + 1, r);
        pull(x);
        return x;
    }

    int merge(int x, int y) { return merge(x, y, 1, size); }

    i64 query(int u, int l, int r, int ql, int qr) const {
        if(!u || qr < l || r < ql) return 0;
        if(ql <= l && r <= qr) return tree[u].sum;
        int mid = midpoint(l, r);
        return query(tree[u].left, l, mid, ql, qr)
             + query(tree[u].right, mid + 1, r, ql, qr);
    }

    i64 query(int root, int l, int r) const {
        assert(1 <= l && l <= r && r <= size);
        return query(root, 1, size, l, r);
    }

    // k is one-based; return -1 when the multiset has fewer than k elements.
    int kth(int root, i64 k) const {
        if(k <= 0 || k > tree[root].sum) return -1;
        int l = 1, r = size;
        while(l < r) {
            int mid = midpoint(l, r);
            i64 leftSize = tree[tree[root].left].sum;
            if(k <= leftSize) root = tree[root].left, r = mid;
            else k -= leftSize, root = tree[root].right, l = mid + 1;
        }
        return l;
    }
};
