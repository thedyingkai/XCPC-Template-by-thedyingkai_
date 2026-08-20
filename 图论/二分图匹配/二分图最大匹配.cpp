#include "../../template/start.cpp"

struct HopcroftKarp {
    int n, m, ans;
    vector<vector<int>> g;
    int shortest;
    vector<int> ml, mr, dis, cur;
    HopcroftKarp(int n_, int m_) : n(n_), m(m_), ans(0), g(n + 1), shortest(-1), ml(n + 1), mr(m + 1), dis(n + 1), cur(n + 1) {}
    void add(int u, int v) { g[u].push_back(v); }
    bool bfs() {
        queue<int> q;
        fill(dis.begin(), dis.end(), -1);
        for(int u = 1; u <= n; u++)
            if(!ml[u]) dis[u] = 0, q.push(u);
        fill(cur.begin(), cur.end(), 0);
        shortest = -1;
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            if(shortest != -1 && dis[u] + 1 > shortest) continue;
            for(int v : g[u]) {
                if(!mr[v])
                    shortest = dis[u] + 1;
                else if(dis[mr[v]] == -1)
                    dis[mr[v]] = dis[u] + 1, q.push(mr[v]);
            }
        }
        return shortest != -1;
    }
    bool dfs(int start) {
        vector<int> leftPath = {start}, rightPath;
        leftPath.reserve(shortest + 1), rightPath.reserve(shortest);
        while(!leftPath.empty()) {
            int u = leftPath.back();
            bool advanced = false;
            while(cur[u] < (int) g[u].size()) {
                int v = g[u][cur[u]++];
                if(!mr[v]) {
                    if(dis[u] + 1 != shortest) continue;
                    rightPath.push_back(v);
                    for(int i = (int) leftPath.size() - 1; i >= 0; i--)
                        ml[leftPath[i]] = rightPath[i], mr[rightPath[i]] = leftPath[i];
                    return true;
                }
                int next = mr[v];
                if(dis[next] != dis[u] + 1) continue;
                rightPath.push_back(v), leftPath.push_back(next);
                advanced = true;
                break;
            }
            if(advanced) continue;
            dis[u] = -1;
            bool hasParent = leftPath.size() > 1;
            leftPath.pop_back();
            if(hasParent) rightPath.pop_back();
        }
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
