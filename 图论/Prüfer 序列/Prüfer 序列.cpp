#include "../../template/start.cpp"

// start: heap
// Vertices are 1..n. The input must be a labelled tree and n >= 2.
vector<int> pruferEncode(int n, const vector<pair<int, int>>& edges) {
    if(n < 2 || (int) edges.size() != n - 1) return {};
    vector<vector<int>> graph(n + 1);
    vector<int> degree(n + 1);
    for(auto [u, v] : edges) {
        if(u < 1 || u > n || v < 1 || v > n) return {};
        graph[u].push_back(v), graph[v].push_back(u);
        degree[u]++, degree[v]++;
    }
    priority_queue<int, vector<int>, greater<int>> leaves;
    for(int u = 1; u <= n; u++) if(degree[u] == 1) leaves.push(u);

    vector<int> code;
    code.reserve(n - 2);
    for(int step = 0; step < n - 2; step++) {
        if(leaves.empty()) return {};
        int leaf = leaves.top();
        leaves.pop();
        int parent = 0;
        for(int v : graph[leaf]) if(degree[v] > 0) {
            parent = v;
            break;
        }
        if(parent == 0) return {};
        code.push_back(parent);
        degree[leaf] = 0;
        if(--degree[parent] == 1) leaves.push(parent);
    }
    return code;
}

// A code of length n-2 describes a tree on vertices 1..n.
vector<pair<int, int>> pruferDecode(const vector<int>& code) {
    int n = (int) code.size() + 2;
    vector<int> degree(n + 1, 1);
    for(int x : code) {
        if(x < 1 || x > n) return {};
        degree[x]++;
    }
    priority_queue<int, vector<int>, greater<int>> leaves;
    for(int u = 1; u <= n; u++) if(degree[u] == 1) leaves.push(u);

    vector<pair<int, int>> edges;
    edges.reserve(n - 1);
    for(int x : code) {
        int leaf = leaves.top();
        leaves.pop();
        edges.push_back({leaf, x});
        degree[leaf]--;
        if(--degree[x] == 1) leaves.push(x);
    }
    int u = leaves.top();
    leaves.pop();
    int v = leaves.top();
    edges.push_back({u, v});
    return edges;
}
// end: heap

// start: linear
// parent[1..n-1] is a tree rooted at n, parent[n]=0. Runs in O(n).
vector<int> pruferEncodeLinear(const vector<int>& parent) {
    int n = (int) parent.size() - 1;
    if(n < 2 || parent[n] != 0) return {};
    vector<int> childCount(n + 1);
    for(int u = 1; u < n; u++) {
        if(parent[u] < 1 || parent[u] > n || parent[u] == u) return {};
        childCount[parent[u]]++;
    }
    int pointer = 1;
    while(pointer <= n && childCount[pointer] != 0) pointer++;
    int leaf = pointer;
    vector<int> code;
    code.reserve(n - 2);
    for(int step = 0; step < n - 2; step++) {
        if(leaf >= n) return {};
        int p = parent[leaf];
        code.push_back(p);
        if(--childCount[p] == 0 && p < pointer) {
            leaf = p;
        } else {
            do pointer++; while(pointer <= n && childCount[pointer] != 0);
            leaf = pointer;
        }
    }
    return code;
}

// Returns parent[1..n] for the tree rooted at n. Runs in O(n).
vector<int> pruferDecodeLinear(const vector<int>& code) {
    int n = (int) code.size() + 2;
    vector<int> remaining(n + 1), parent(n + 1);
    for(int value : code) {
        if(value < 1 || value > n) return {};
        remaining[value]++;
    }
    int pointer = 1;
    while(pointer <= n && remaining[pointer] != 0) pointer++;
    int leaf = pointer;
    for(int value : code) {
        if(leaf >= n) return {};
        parent[leaf] = value;
        if(--remaining[value] == 0 && value < pointer) {
            leaf = value;
        } else {
            do pointer++; while(pointer <= n && remaining[pointer] != 0);
            leaf = pointer;
        }
    }
    if(leaf >= n) return {};
    parent[leaf] = n;
    return parent;
}
// end: linear
