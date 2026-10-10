#pragma once
#include "../../../template/start.cpp"

struct StrictSecondMST {
    struct Edge { int u, v; i64 w; };
    struct MaxTwo {
        i64 first = 0, second = 0;
        int count = 0;
        void add(i64 x) {
            if(count == 0) first = x, count = 1;
            else if(x > first) second = first, first = x, count = 2;
            else if(x < first && (count == 1 || x > second)) second = x, count = 2;
        }
    };
    static MaxTwo combine(MaxTwo a, const MaxTwo& b) {
        if(b.count >= 1) a.add(b.first);
        if(b.count == 2) a.add(b.second);
        return a;
    }

    bool connected = false;
    i128 mstWeight = 0;
    optional<i128> secondWeight;
    vector<int> treeEdges; // Indices in the input edge vector.

    StrictSecondMST(int n, const vector<Edge>& edges) {
        assert(n >= 1);
        int m = (int) edges.size(), levels = (int) bit_width((unsigned) n);
        vector<int> parent(n + 1), size(n + 1, 1), ids(m);
        iota(parent.begin(), parent.end(), 0);
        iota(ids.begin(), ids.end(), 0);
        auto find = [&](int x) {
            while(x != parent[x]) x = parent[x] = parent[parent[x]];
            return x;
        };
        for(auto [u, v, w] : edges)
            assert(1 <= u && u <= n && 1 <= v && v <= n);
        sort(ids.begin(), ids.end(), [&](int x, int y) {
            return pair(edges[x].w, x) < pair(edges[y].w, y);
        });
        vector<bool> used(m);
        vector<vector<pair<int, i64>>> graph(n + 1);
        for(int id : ids) {
            auto [u, v, w] = edges[id];
            int x = find(u), y = find(v);
            if(x == y) continue;
            if(size[x] < size[y]) swap(x, y);
            parent[y] = x;
            size[x] += size[y];
            used[id] = true;
            treeEdges.push_back(id);
            mstWeight += (i128) w;
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }
        if((int) treeEdges.size() != n - 1) return;
        connected = true;
        vector<vector<int>> up(levels, vector<int>(n + 1));
        vector<vector<MaxTwo>> mx(levels, vector<MaxTwo>(n + 1));
        vector<int> depth(n + 1), order{1};
        for(int i = 0; i < n; i++) {
            int u = order[i];
            for(auto [v, w] : graph[u]) {
                if(v == up[0][u]) continue;
                up[0][v] = u;
                depth[v] = depth[u] + 1;
                mx[0][v].add(w);
                order.push_back(v);
            }
        }
        for(int k = 1; k < levels; k++)
            for(int u = 1; u <= n; u++) {
                int p = up[k - 1][u];
                up[k][u] = up[k - 1][p];
                mx[k][u] = combine(mx[k - 1][u], mx[k - 1][p]);
            }
        auto pathMax = [&](int u, int v) {
            MaxTwo answer;
            if(depth[u] < depth[v]) swap(u, v);
            int delta = depth[u] - depth[v];
            for(int k = 0; k < levels; k++)
                if((delta >> k) & 1) answer = combine(answer, mx[k][u]), u = up[k][u];
            if(u == v) return answer;
            for(int k = levels - 1; k >= 0; k--)
                if(up[k][u] != up[k][v]) {
                    answer = combine(answer, combine(mx[k][u], mx[k][v]));
                    u = up[k][u], v = up[k][v];
                }
            return combine(answer, combine(mx[0][u], mx[0][v]));
        };
        for(int id = 0; id < m; id++) {
            auto [u, v, w] = edges[id];
            if(used[id] || u == v) continue;
            MaxTwo path = pathMax(u, v);
            i64 removed;
            if(w > path.first) removed = path.first;
            else if(path.count == 2) removed = path.second;
            else continue;
            i128 candidate = mstWeight + (i128) w - removed;
            if(!secondWeight || candidate < *secondWeight) secondWeight = candidate;
        }
    }
};
