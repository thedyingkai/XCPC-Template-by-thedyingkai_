#pragma once
#include "../../../template/start.cpp"

struct XorMSTResult {
    i128 weight = 0;
    vector<pair<int, int>> edges; // Zero-based ORIGINAL vertex indices.
};

XorMSTResult xorMST(const vector<u64>& value) {
    XorMSTResult result;
    vector<int> order(value.size());
    iota(order.begin(), order.end(), 0);
    sort(order.begin(), order.end(), [&](int x, int y) {
        return pair(value[x], x) < pair(value[y], y);
    });
    vector<u64> a;
    vector<int> original;
    for(int id : order) {
        if(!a.empty() && a.back() == value[id])
            result.edges.push_back({original.back(), id});
        else a.push_back(value[id]), original.push_back(id);
    }
    int n = (int) a.size();
    if(n <= 1) return result;
    int bits = max(1, (int) bit_width(a.back()));

    struct Node {
        int child[2] = {-1, -1};
        int low = 0, high = 0, vertex = -1;
    };
    vector<Node> trie(1);
    for(int i = 0; i < n; i++) {
        int u = 0;
        for(int bit = bits - 1; bit >= 0; bit--) {
            int digit = (a[i] >> bit) & 1;
            if(trie[u].child[digit] == -1) {
                int child = (int) trie.size();
                trie.push_back({});
                trie[u].child[digit] = child;
            }
            u = trie[u].child[digit];
        }
        trie[u].vertex = i;
    }
    vector<int> parent(n), size(n, 1), color(n);
    iota(parent.begin(), parent.end(), 0);
    auto find = [&](int x) {
        while(x != parent[x]) x = parent[x] = parent[parent[x]];
        return x;
    };

    for(int components = n; components > 1; ) {
        for(auto& node : trie) node.low = n, node.high = -1;
        for(int i = 0; i < n; i++) {
            color[i] = find(i);
            int u = 0;
            for(int bit = bits - 1; ; bit--) {
                trie[u].low = min(trie[u].low, color[i]);
                trie[u].high = max(trie[u].high, color[i]);
                if(bit < 0) break;
                u = trie[u].child[(a[i] >> bit) & 1];
            }
        }
        vector<pair<int, int>> best(n, {-1, -1});
        for(int i = 0; i < n; i++) {
            int u = 0;
            for(int bit = bits - 1; bit >= 0; bit--) {
                int digit = (a[i] >> bit) & 1;
                int next = trie[u].child[digit];
                if(next == -1 || (trie[next].low == color[i]
                                   && trie[next].high == color[i]))
                    digit ^= 1;
                u = trie[u].child[digit];
                assert(u != -1);
            }
            int j = trie[u].vertex;
            auto& [x, y] = best[color[i]];
            if(x == -1 || (a[i] ^ a[j]) < (a[x] ^ a[y])) x = i, y = j;
        }
        // Colors remain fixed while selecting this round's outgoing edges.
        for(auto [x, y] : best) {
            if(x == -1) continue;
            int rx = find(x), ry = find(y);
            if(rx == ry) continue;
            if(size[rx] < size[ry]) swap(rx, ry);
            parent[ry] = rx;
            size[rx] += size[ry];
            components--;
            result.weight += (i128) (a[x] ^ a[y]);
            result.edges.push_back({original[x], original[y]});
        }
    }
    return result;
}
