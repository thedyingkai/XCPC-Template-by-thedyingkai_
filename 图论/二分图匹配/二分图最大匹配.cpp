#include "../../template/start.cpp"

struct HopcroftKarp {
    int n, m, ans;
    vector<vector<int>> g;
    vector<int> ml, mr, dis, cur;
    HopcroftKarp(int n_, int m_) : n(n_), m(m_), ans(0), g(n + 1), ml(n + 1), mr(m + 1), dis(n + 1), cur(n + 1) {}
    void add(int u, int v) { g[u].push_back(v); }
    bool bfs() {
        queue<int> q;
        fill(dis.begin(), dis.end(), -1);
        for(int u = 1; u <= n; u++)
            if(!ml[u]) dis[u] = 0, q.push(u);
        fill(cur.begin(), cur.end(), 0);
        bool found = false;
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int v : g[u]) {
                if(!mr[v])
                    found = true;
                else if(dis[mr[v]] == -1)
                    dis[mr[v]] = dis[u] + 1, q.push(mr[v]);
            }
        }
        return found;
    }
    bool dfs(int u) {
        for(int& i = cur[u]; i < (int) g[u].size(); i++) {
            int v = g[u][i];
            if(!mr[v] || (dis[mr[v]] == dis[u] + 1 && dfs(mr[v]))) {
                ml[u] = v, mr[v] = u;
                return true;
            }
        }
        dis[u] = -1;
        return false;
    }
    int maxMatching() {
        while(bfs())
            for(int u = 1; u <= n; u++)
                if(!ml[u] && dfs(u)) ans++;
        return ans;
    }
    pair<vector<int>, vector<int>> minVertexCover() {
        maxMatching();
        vector<int> vl(n + 1), vr(m + 1);
        queue<int> q;
        for(int u = 1; u <= n; u++)
            if(!ml[u]) vl[u] = 1, q.push(u);
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int v : g[u]) {
                if(ml[u] == v || vr[v]) continue;
                vr[v] = 1;
                if(mr[v] && !vl[mr[v]]) vl[mr[v]] = 1, q.push(mr[v]);
            }
        }
        vector<int> left, right;
        for(int u = 1; u <= n; u++)
            if(!vl[u]) left.push_back(u);
        for(int v = 1; v <= m; v++)
            if(vr[v]) right.push_back(v);
        return {left, right};
    }
};
