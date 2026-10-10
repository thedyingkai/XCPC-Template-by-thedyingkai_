#include <bits/stdc++.h>
using namespace std;
const int maxn = 2e5 + 10;
const int INF = 1e9 + 10;
int n, vis[maxn], sz[maxn], root, best;
vector<pair<int, int>> son[maxn];
// best、mx：找重心用的
void getsz(int u, int fa) {
    sz[u] = 1;
    for(auto& [v, w] : son[u]) {
        if(v == fa || vis[v]) continue;
        getsz(v, u);
        sz[u] += sz[v];
    }
}
void getroot(int u, int fa, int tot) {
    int mx = tot - sz[u];
    for(auto& [v, w] : son[u]) {
        if(vis[v] || v == fa) continue;
        getroot(v, u, tot);
        mx = max(mx, sz[v]);
    }
    if(mx < best) {
        best = mx;
        root = u;
    }
}
void calc(int rt) {
    // Do sth.
    for(auto& [v, w] : son[rt]) {
        if(vis[v]) continue;
        // Do sth.
    }
    // Do sth.
}
void solve(int u) {
    getsz(u, 0);
    best = INF;
    root = 0;
    getroot(u, 0, sz[u]);
    calc(root);
    vis[root] = 1;
    for(auto& [v, w] : son[root]) {
        if(vis[v]) continue;
        solve(v);
    }
}
int main() {
    ios::sync_with_stdio(false);
    // Input And Prepare
    solve(1);
    // Output
    return 0;
}
