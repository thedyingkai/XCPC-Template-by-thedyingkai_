#include <template/start.cpp>

struct Trie {
    struct Node {
        int ch[2];
        Node() : ch{-1, -1} {}
    };
    vector<Node> nodes;
    Trie() { nodes.emplace_back(); }
    void insert(int val) {
        int cur = 0;
        for(int i = 30; i >= 0; --i) {
            int b = (val >> i) & 1;
            if(nodes[cur].ch[b] == -1) {
                nodes[cur].ch[b] = (int) nodes.size();
                nodes.emplace_back();
            }
            cur = nodes[cur].ch[b];
        }
    }
    int query(int val) const {
        int cur = 0;
        int res = 0;
        for(int i = 30; i >= 0; --i) {
            int b = (val >> i) & 1;
            int want = b ^ 1;
            if(nodes[cur].ch[want] != -1) {
                res |= (1 << i);
                cur = nodes[cur].ch[want];
            } else {
                cur = nodes[cur].ch[b];
            }
        }
        return res;
    }
};
int main() {
    int n;
    cin >> n;
    vector<vector<pair<int, int>>> g(n + 1);
    for(int i = 1; i < n; ++i) {
        int u, v, w;
        cin >> u >> v >> w;
        g[u].emplace_back(v, w);
        g[v].emplace_back(u, w);
    }
    vector<int> sum(n + 1, 0);
    function<void(int, int)> dfs = [&](int u, int fa) {
        for(auto [v, w] : g[u]) {
            if(v == fa) continue;
            sum[v] = sum[u] ^ w;
            dfs(v, u);
        }
    };
    dfs(1, 0);
    Trie trie;
    for(int i = 1; i <= n; ++i) trie.insert(sum[i]);
    int ans = 0;
    for(int i = 1; i <= n; ++i) ans = max(ans, trie.query(sum[i]));
    cout << ans << "\n";
}
