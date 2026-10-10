#include "../../template/start.cpp"

struct Euler {
    int n, m;
    bool directed;
    vector<vector<int>> g;
    vector<int> a, b, in, out;
    Euler(int n_, bool directed_) : n(n_), m(0), directed(directed_), g(n + 1), in(n + 1), out(n + 1) {}
    void add(int u, int v) {
        a.push_back(u), b.push_back(v);
        g[u].push_back(m);
        if(!directed) g[v].push_back(m);
        out[u]++, in[v]++;
        m++;
    }
    vector<int> trail(int start = 0) const {
        int s = 0;
        if(directed) {
            int sc = 0, tc = 0;
            for(int u = 1; u <= n; u++) {
                int d = out[u] - in[u];
                if(d == 1)
                    s = u, sc++;
                else if(d == -1)
                    tc++;
                else if(d != 0)
                    return {};
            }
            if(sc != tc || sc > 1) return {};
            if(sc == 0)
                for(int u = 1; u <= n && !s; u++)
                    if(out[u]) s = u;
        } else {
            int odd = 0;
            for(int u = 1; u <= n; u++) {
                if((in[u] + out[u]) & 1) s = u, odd++;
            }
            if(odd != 0 && odd != 2) return {};
            if(odd == 0)
                for(int u = 1; u <= n && !s; u++)
                    if(in[u] + out[u]) s = u;
        }
        if(start) {
            if(directed && s && out[s] - in[s] == 1 && start != s) return {};
            if(!directed) {
                int odd = 0;
                for(int u = 1; u <= n; u++) odd += (in[u] + out[u]) & 1;
                if(odd == 2 && !((in[start] + out[start]) & 1)) return {};
            }
            s = start;
        }
        if(!s) s = 1;
        vector<int> it(n + 1), used(m), stk = {s}, path;
        while(!stk.empty()) {
            int u = stk.back();
            while(it[u] < (int) g[u].size() && used[g[u][it[u]]]) it[u]++;
            if(it[u] == (int) g[u].size()) {
                path.push_back(u);
                stk.pop_back();
            } else {
                int id = g[u][it[u]++];
                used[id] = 1;
                int v = directed ? b[id] : (a[id] == u ? b[id] : a[id]);
                stk.push_back(v);
            }
        }
        if((int) path.size() != m + 1) return {};
        reverse(path.begin(), path.end());
        return path;
    }
};
