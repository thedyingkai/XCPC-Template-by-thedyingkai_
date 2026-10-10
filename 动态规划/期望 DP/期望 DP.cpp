#pragma once
#include "../../template/start.cpp"

const int N = 100005, M = 200005;
int head[N], nxt[M], to[M], wt[M], ecnt;
int outdeg[N], indeg[N];
double E[N];
int q[N], topo[N], tcnt;

void expectation_DP() {
    int n, m;
    scanf("%d %d", &n, &m);
    for (int i = 0; i < m; ++i) {
        int u, v, w;
        scanf("%d %d %d", &u, &v, &w);
        to[++ecnt] = v; wt[ecnt] = w; nxt[ecnt] = head[u]; head[u] = ecnt;
        ++outdeg[u]; ++indeg[v];
    }

    int h = 0, t = 0;                                  // Kahn 拓扑排序
    for (int i = 1; i <= n; ++i) if (!indeg[i]) q[t++] = i;
    while (h < t) {
        int u = q[h++]; topo[tcnt++] = u;
        for (int e = head[u]; e; e = nxt[e])
            if (--indeg[to[e]] == 0) q[t++] = to[e];
    }

    for (int i = tcnt - 1; i >= 0; --i) {              // 逆拓扑序倒推
        int u = topo[i];
        if (u == n) { E[u] = 0; continue; }
        double s = 0;
        for (int e = head[u]; e; e = nxt[e]) s += (double)wt[e] + E[to[e]];
        E[u] = s / outdeg[u];
    }

    printf("%.2f\n", E[1]);
}
