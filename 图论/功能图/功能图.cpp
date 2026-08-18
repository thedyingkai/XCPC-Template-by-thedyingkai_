#pragma once

#include "../../template/start.cpp"

struct FunctionalGraph {
    int n, cc;
    vector<int> to, onCycle, dep, entry, cid, pos, cycleLen;
    vector<vector<int>> rev, up;
    FunctionalGraph(const vector<int>& nxt)
        : n((int) nxt.size() - 1), cc(0), to(nxt), onCycle(n + 1), dep(n + 1),
          entry(n + 1), cid(n + 1), pos(n + 1), rev(n + 1) {
        build();
    }
    void build() {
        vector<int> deg(n + 1), alive(n + 1, 1);
        for(int u = 1; u <= n; u++) {
            assert(1 <= to[u] && to[u] <= n);
            deg[to[u]]++;
            rev[to[u]].push_back(u);
        }
        queue<int> q;
        for(int u = 1; u <= n; u++) if(!deg[u]) q.push(u);
        while(!q.empty()) {
            int u = q.front();
            q.pop(), alive[u] = 0;
            if(--deg[to[u]] == 0) q.push(to[u]);
        }
        cycleLen.push_back(0);
        for(int s = 1; s <= n; s++) if(alive[s] && !cid[s]) {
            int id = ++cc, u = s, p = 0;
            do {
                onCycle[u] = 1;
                cid[u] = id, entry[u] = u, pos[u] = p++;
                u = to[u];
            } while(u != s);
            cycleLen.push_back(p);
        }
        for(int u = 1; u <= n; u++) if(onCycle[u]) q.push(u);
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int v : rev[u]) {
                if(onCycle[v] || cid[v]) continue;
                cid[v] = cid[u], entry[v] = entry[u], dep[v] = dep[u] + 1;
                q.push(v);
            }
        }
        up.assign(64, vector<int>(n + 1));
        for(int u = 1; u <= n; u++) up[0][u] = to[u];
        for(int j = 1; j < 64; j++)
            for(int u = 1; u <= n; u++) up[j][u] = up[j - 1][up[j - 1][u]];
    }
    int jump(int u, u64 k) const {
        for(int j = 0; j < 64; j++) if(k >> j & 1ULL) u = up[j][u];
        return u;
    }
    i64 distance(int x, int y) const {
        if(cid[x] != cid[y]) return -1;
        if(!onCycle[y]) {
            if(dep[x] < dep[y]) return -1;
            int d = dep[x] - dep[y];
            return jump(x, d) == y ? d : -1;
        }
        int len = cycleLen[cid[x]];
        int around = (pos[y] - pos[entry[x]] + len) % len;
        return dep[x] + around;
    }
    int orbitSize(int u) const { return dep[u] + cycleLen[cid[u]]; }
};
