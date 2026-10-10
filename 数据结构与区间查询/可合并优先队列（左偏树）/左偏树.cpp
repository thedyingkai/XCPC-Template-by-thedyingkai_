#pragma once
#include "../../template/start.cpp"

struct LeftistHeap {
    struct Node {
        i64 key = 0;
        int left = 0, right = 0, rank = 0;
    };
    vector<Node> tree{Node{}}; // 0 is the empty heap, rank[0]=0.

    int newNode(i64 key) {
        tree.push_back({key, 0, 0, 1});
        return (int) tree.size() - 1;
    }

    // Destructive: x and y must be roots of disjoint heaps.
    int merge(int x, int y) {
        if(!x || !y) return x | y;
        assert(x != y);
        if(pair(tree[x].key, x) > pair(tree[y].key, y)) swap(x, y);
        tree[x].right = merge(tree[x].right, y);
        if(tree[tree[x].left].rank < tree[tree[x].right].rank)
            swap(tree[x].left, tree[x].right);
        tree[x].rank = tree[tree[x].right].rank + 1;
        return x;
    }

    i64 top(int root) const {
        assert(root != 0);
        return tree[root].key;
    }

    int pop(int root) {
        assert(root != 0);
        int result = merge(tree[root].left, tree[root].right);
        tree[root].left = tree[root].right = 0;
        tree[root].rank = 1;
        return result;
    }
};
