#include <template/start.cpp>

struct RMQ {
    static constexpr int M = 8;
    int blocklen, block;
    vector<int> Minv, T, S;
    vector<vector<int>> F;
    int f[1 << (M - 1)][M][M];
    RMQ() { memset(f, 0, sizeof(f)); }
    void init(int n) {
        if(n <= 0) n = 1; // 防止n为0
        blocklen = max(1, min(M - 1, (int) (log2(n + 1) / 2)));
        block = (n + blocklen - 1) / blocklen;
        Minv.assign(block + 2, 0) T.assign(n + 10, 0);
        S.assign(block + 2, 0);
        F.assign(block + 2, vector<int>(25, 0));
        int total = 1 << (blocklen - 1);
        for(int i = 0; i < total; i++) {
            for(int l = 0; l < blocklen; l++) {
                f[i][l][l] = l;
                int now = 0, minv = 0;
                for(int r = l + 1; r < blocklen; r++) {
                    f[i][l][r] = f[i][l][r - 1];
                    if((1 << (r - 1)) & i)
                        now++;
                    else {
                        now--;
                        if(now < minv) {
                            minv = now;
                            f[i][l][r] = r;
                        }
                    }
                }
            }
        }
        T[0] = T[1] = 0;
        for(int i = 2; i < (int) T.size(); i++) {
            T[i] = T[i - 1];
            if((i & (i - 1)) == 0) T[i]++;
        }
    }
    void initmin(const vector<int>& a) {
        int n = (int) a.size();
        if(n == 0) return;
        for(int i = 0; i < n; i++) {
            int block_id = i / blocklen;
            if(block_id >= block) break; // 防止越界
            if(i % blocklen == 0) {
                Minv[block_id] = i;
                S[block_id] = 0;
            } else {
                if(a[i] < a[Minv[block_id]]) Minv[block_id] = i;
                int bit_pos = i % blocklen - 1;
                if(bit_pos >= 0 && bit_pos < blocklen - 1 && a[i] > a[i - 1]) S[block_id] |= 1 << bit_pos;
            }
        }
        for(int i = 0; i < block; i++) F[i][0] = Minv[i];
        for(int j = 1; (1 << j) <= block; j++) {
            for(int i = 0; i + (1 << j) - 1 < block; i++) {
                int b1 = F[i][j - 1], b2 = F[i + (1 << (j - 1))][j - 1];
                F[i][j] = a[b1] < a[b2] ? b1 : b2;
            }
        }
    }
    int querymin(const vector<int>& a, int L, int R) {
        if(L > R) swap(L, R);
        int idl = L / blocklen, idr = R / blocklen;
        if(idl == idr) {
            int l_mod = L % blocklen;
            int r_mod = R % blocklen;
            if(l_mod >= blocklen) l_mod = blocklen - 1;
            if(r_mod >= blocklen) r_mod = blocklen - 1;
            return idl * blocklen + f[S[idl]][l_mod][r_mod];
        } else {
            int l_mod = L % blocklen;
            int r_mod = R % blocklen;
            if(l_mod >= blocklen) l_mod = blocklen - 1;
            if(r_mod >= blocklen) r_mod = blocklen - 1;
            int b1 = idl * blocklen + f[S[idl]][l_mod][blocklen - 1];
            int b2 = idr * blocklen + f[S[idr]][0][r_mod];
            int buf = a[b1] < a[b2] ? b1 : b2;
            int len = idr - idl - 1;
            if(len > 0) {
                int c = T[len];
                if(c >= 24) c = 23; // 防止越界
                int b3 = F[idl + 1][c];
                int b4 = F[idr - (1 << c)][c];
                int b = a[b3] < a[b4] ? b3 : b4;
                return a[buf] < a[b] ? buf : b;
            }
            return buf;
        }
    }
};
struct LCA_RMQ {
    int n, tot, dfs_clock;
    vector<int> head, dfn, dep, st;
    struct Edge {
        int v, nxt;
    };
    vector<Edge> e;
    RMQ rmq;
    LCA_RMQ(int _n) : n(_n) {
        head.assign(n + 1, 0);
        e.resize(4 * n + 50); // 增大边数组
        tot = 0;
        dfn.resize(4 * n + 50);
        dep.resize(4 * n + 50);
        st.assign(n + 1, 0);
        dfs_clock = 0;
    }
    void addedge(int u, int v) {
        e[++tot] = {v, head[u]};
        head[u] = tot;
        e[++tot] = {u, head[v]};
        head[v] = tot;
    }
    void dfs(int u, int fa, int depth) {
        st[u] = dfs_clock;
        dfn[dfs_clock] = u;
        dep[dfs_clock++] = depth;
        for(int i = head[u]; i; i = e[i].nxt) {
            int v = e[i].v;
            if(v == fa) continue;
            dfs(v, u, depth + 1);
            dfn[dfs_clock] = u;
            dep[dfs_clock++] = depth;
        }
    }
    void build(int root = 1) {
        dfs_clock = 0;
        dfs(root, 0, 0);
        rmq.init(dfs_clock);
        if(dfs_clock > (int) dep.size()) dep.resize(dfs_clock + 10);
        rmq.initmin(dep);
    }
    int lca(int u, int v) {
        int L = st[u], R = st[v];
        if(L > R) swap(L, R);
        int idx = rmq.querymin(dep, L, R);
        return dfn[idx];
    }
};
