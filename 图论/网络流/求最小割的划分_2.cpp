#include <template/start.cpp>

vector<int> d(n + 1);
vector<vector<int>> g(n + 1);
for(int i = 1; i <= n; i++) {
    for(int j = dinic.h[i]; j; j = dinic.e[j].ne) {
        auto [v, c, ne] = dinic.e[j];
        if(v > n && v <= 2 * n && c == 0) {
            g[i].push_back(v - n);
            d[v - n]++;
            break;
        }
    }
}
for(int i = 1; i <= n; i++) {
    if(!d[i]) {
        int j = i;
        while(g[j].size()) {
            cout << j << ' ';
            j = g[j][0];
        }
        cout << j << endl;
        ;
    }
}
