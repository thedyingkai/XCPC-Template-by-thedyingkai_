#pragma once

#include "../../template/start.cpp"

struct EulerTourTree {
    struct Node {
        int child[2] = {0, 0};
        int parent = 0;
        int size = 1;
        int vertexCount = 0;
        unsigned priority = 0;
        i64 value = 0;
        i64 sum = 0;
    };

    int n;
    mt19937 rng;
    vector<Node> tree;
    vector<int> self;
    unordered_map<u64, pair<int, int>> edgeNode;

    explicit EulerTourTree(int n_ = 0)
        : n(n_), rng((unsigned) chrono::steady_clock::now().time_since_epoch().count()),
          tree(1), self(n_ + 1) {
        for(int i = 1; i <= n; i++) self[i] = newNode(0, true);
    }

    static u64 edgeKey(int u, int v) {
        if(u > v) swap(u, v);
        return (u64)(unsigned) u << 32 | (unsigned) v;
    }

    int newNode(i64 value, bool isVertex) {
        Node node;
        node.priority = rng();
        node.value = node.sum = value;
        node.vertexCount = isVertex;
        tree.push_back(node);
        return (int) tree.size() - 1;
    }

    int size(int u) const { return u ? tree[u].size : 0; }
    int vertexCount(int u) const { return u ? tree[u].vertexCount : 0; }
    i64 sum(int u) const { return u ? tree[u].sum : 0; }

    void pull(int u) {
        tree[u].size = 1 + size(tree[u].child[0]) + size(tree[u].child[1]);
        tree[u].sum = tree[u].value + sum(tree[u].child[0]) + sum(tree[u].child[1]);
        tree[u].vertexCount = (u <= n ? 1 : 0) + vertexCount(tree[u].child[0])
                              + vertexCount(tree[u].child[1]);
    }

    int merge(int a, int b) {
        if(!a || !b) {
            int root = a | b;
            if(root) tree[root].parent = 0;
            return root;
        }
        if(tree[a].priority > tree[b].priority) {
            tree[a].child[1] = merge(tree[a].child[1], b);
            if(tree[a].child[1]) tree[tree[a].child[1]].parent = a;
            pull(a);
            tree[a].parent = 0;
            return a;
        }
        tree[b].child[0] = merge(a, tree[b].child[0]);
        if(tree[b].child[0]) tree[tree[b].child[0]].parent = b;
        pull(b);
        tree[b].parent = 0;
        return b;
    }

    pair<int, int> split(int root, int leftSize) {
        if(!root) return {0, 0};
        if(size(tree[root].child[0]) >= leftSize) {
            auto [a, b] = split(tree[root].child[0], leftSize);
            tree[root].child[0] = b;
            if(b) tree[b].parent = root;
            pull(root);
            tree[root].parent = 0;
            if(a) tree[a].parent = 0;
            return {a, root};
        }
        int used = size(tree[root].child[0]) + 1;
        auto [a, b] = split(tree[root].child[1], leftSize - used);
        tree[root].child[1] = a;
        if(a) tree[a].parent = root;
        pull(root);
        tree[root].parent = 0;
        if(b) tree[b].parent = 0;
        return {root, b};
    }

    int rootOf(int u) const {
        while(tree[u].parent) u = tree[u].parent;
        return u;
    }

    int position(int u) {
        int result = size(tree[u].child[0]) + 1;
        while(tree[u].parent) {
            int p = tree[u].parent;
            if(tree[p].child[1] == u) result += size(tree[p].child[0]) + 1;
            u = p;
        }
        return result;
    }

    void reroot(int vertex) {
        int marker = self[vertex], root = rootOf(marker);
        int before = position(marker) - 1;
        auto [a, b] = split(root, before);
        merge(b, a);
    }

    bool connected(int u, int v) const { return rootOf(self[u]) == rootOf(self[v]); }

    bool link(int u, int v) {
        if(u == v || connected(u, v)) return false;
        reroot(u);
        reroot(v);
        int uv = newNode(0, false), vu = newNode(0, false);
        int left = rootOf(self[u]), right = rootOf(self[v]);
        merge(merge(merge(left, uv), right), vu);
        edgeNode[edgeKey(u, v)] = {uv, vu};
        return true;
    }

    bool cut(int u, int v) {
        auto iterator = edgeNode.find(edgeKey(u, v));
        if(iterator == edgeNode.end()) return false;
        reroot(u);
        int first = iterator->second.first, second = iterator->second.second;
        int firstPosition = position(first), secondPosition = position(second);
        if(firstPosition > secondPosition) {
            swap(first, second);
            swap(firstPosition, secondPosition);
        }
        int root = rootOf(first);
        auto [left, fromFirst] = split(root, firstPosition - 1);
        auto [firstNode, afterFirst] = split(fromFirst, 1);
        auto [middle, fromSecond] = split(afterFirst, secondPosition - firstPosition - 1);
        auto [secondNode, right] = split(fromSecond, 1);
        merge(right, left);
        if(firstNode) tree[firstNode].parent = 0;
        if(secondNode) tree[secondNode].parent = 0;
        if(middle) tree[middle].parent = 0;
        edgeNode.erase(iterator);
        return true;
    }

    void setValue(int vertex, i64 value) {
        int u = self[vertex];
        tree[u].value = value;
        while(u) {
            pull(u);
            u = tree[u].parent;
        }
    }

    i64 componentSum(int vertex) const { return tree[rootOf(self[vertex])].sum; }
    int componentSize(int vertex) const { return tree[rootOf(self[vertex])].vertexCount; }
};
