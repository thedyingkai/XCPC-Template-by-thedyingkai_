#pragma once

#include "../../template/start.cpp"

struct LinkCutTree {
    struct Info {
        int size = 0;
        i64 sum = 0;
        i64 maximum = numeric_limits<i64>::lowest();
        i64 xorSum = 0;
    };
    struct Node {
        int child[2] = {0, 0};
        int parent = 0;
        bool reverse = false;
        i64 value = 0;
        Info info;
    };

    vector<Node> tree;
    vector<int> pendingPush;

    explicit LinkCutTree(int n = 0) : tree(n + 1) {
        pendingPush.reserve(n);
        for(int i = 1; i <= n; i++) pull(i);
    }

    bool isAuxRoot(int x) const {
        int p = tree[x].parent;
        return !p || (tree[p].child[0] != x && tree[p].child[1] != x);
    }

    void applyReverse(int x) {
        if(!x) return;
        swap(tree[x].child[0], tree[x].child[1]);
        tree[x].reverse ^= 1;
    }

    void push(int x) {
        if(!tree[x].reverse) return;
        applyReverse(tree[x].child[0]);
        applyReverse(tree[x].child[1]);
        tree[x].reverse = false;
    }

    void pull(int x) {
        Info result;
        result.size = 1;
        result.sum = result.xorSum = tree[x].value;
        result.maximum = tree[x].value;
        for(int side = 0; side < 2; side++) {
            int child = tree[x].child[side];
            if(!child) continue;
            result.size += tree[child].info.size;
            result.sum += tree[child].info.sum;
            result.maximum = max(result.maximum, tree[child].info.maximum);
            result.xorSum ^= tree[child].info.xorSum;
        }
        tree[x].info = result;
    }

    void pushPath(int x) {
        pendingPush.clear();
        pendingPush.push_back(x);
        while(!isAuxRoot(x)) {
            x = tree[x].parent;
            pendingPush.push_back(x);
        }
        for(auto it = pendingPush.rbegin(); it != pendingPush.rend(); ++it) push(*it);
    }

    void rotate(int x) {
        int p = tree[x].parent, g = tree[p].parent;
        int side = tree[p].child[1] == x;
        int middle = tree[x].child[side ^ 1];
        if(!isAuxRoot(p)) tree[g].child[tree[g].child[1] == p] = x;
        tree[x].parent = g;
        tree[x].child[side ^ 1] = p;
        tree[p].parent = x;
        tree[p].child[side] = middle;
        if(middle) tree[middle].parent = p;
        pull(p);
        pull(x);
    }

    void splay(int x) {
        pushPath(x);
        while(!isAuxRoot(x)) {
            int p = tree[x].parent, g = tree[p].parent;
            if(!isAuxRoot(p)) {
                bool zigzag = (tree[p].child[0] == x) ^ (tree[g].child[0] == p);
                rotate(zigzag ? x : p);
            }
            rotate(x);
        }
    }

    int access(int x) {
        int last = 0;
        for(int y = x; y; y = tree[y].parent) {
            splay(y);
            tree[y].child[1] = last;
            pull(y);
            last = y;
        }
        splay(x);
        return last;
    }

    void makeRoot(int x) {
        access(x);
        applyReverse(x);
    }

    int findRoot(int x) {
        access(x);
        while(push(x), tree[x].child[0]) x = tree[x].child[0];
        splay(x);
        return x;
    }

    bool connected(int u, int v) {
        if(u == v) return true;
        makeRoot(u);
        return findRoot(v) == u;
    }

    bool link(int u, int v) {
        makeRoot(u);
        if(findRoot(v) == u) return false;
        tree[u].parent = v;
        return true;
    }

    bool cut(int u, int v) {
        makeRoot(u);
        access(v);
        if(tree[v].child[0] != u || tree[u].child[1]) return false;
        tree[v].child[0] = 0;
        tree[u].parent = 0;
        pull(v);
        return true;
    }

    void setValue(int x, i64 value) {
        access(x);
        tree[x].value = value;
        pull(x);
    }

    Info queryPath(int u, int v) {
        assert(connected(u, v));
        makeRoot(u);
        access(v);
        return tree[v].info;
    }
};
