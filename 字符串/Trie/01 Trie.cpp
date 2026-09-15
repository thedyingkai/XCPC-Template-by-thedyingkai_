#include "../../template/start.cpp"

struct Trie {
    struct Node {
        int ch[2],val;
        Node() : ch{-1,-1},val(-1) {}
    };
    vector<Node> nodes;
    vector<int> pos;
    Trie() : pos(30,-1) { nodes.emplace_back(); }
    void insert(int val){
        int cur=0;
        for(int i=29;i>=0;i--){
            int b=(val>>i)&1;
            if(nodes[cur].ch[b]==-1){
                nodes[cur].ch[b]=(int)nodes.size();
                nodes.emplace_back();
            }
            if(nodes[cur].ch[0]!=-1&&nodes[cur].ch[1]!=-1) pos[i]=cur;
            cur=nodes[cur].ch[b];
        }
        nodes[cur].val=val;
    }
    int getMax(int cur,int i,int val){
        if(cur==-1) return -1;
        for(int j=i;j>=0;j--){
            int b=((val>>j)&1)^1;
            if(nodes[cur].ch[b]==-1) b^=1;
            cur=nodes[cur].ch[b];
        }
        return nodes[cur].val;
    }
    int getMin(int cur,int i,int val){
        if(cur==-1) return -1;
        for(int j=i;j>=0;j--){
            int b=(val>>j)&1;
            if(nodes[cur].ch[b]==-1) b^=1;
            cur=nodes[cur].ch[b];
        }
        return nodes[cur].val;
    }
};

int main() {
    int n;
    cin >> n;
    if(n <= 0) {
        cout << 0 << "\n";
        return 0;
    }
    vector<vector<pair<int, int>>> g(n + 1);
    for(int i = 1; i < n; ++i) {
        int u, v, w;
        cin >> u >> v >> w;
        g[u].emplace_back(v, w);
        g[v].emplace_back(u, w);
    }
    vector<int> sum(n + 1, 0), parent(n + 1, 0), stack = {1};
    while(!stack.empty()) {
        int u = stack.back();
        stack.pop_back();
        for(auto [v, w] : g[u]) {
            if(v == parent[u]) continue;
            parent[v] = u;
            sum[v] = sum[u] ^ w;
            stack.push_back(v);
        }
    }
    Trie trie;
    for(int i = 1; i <= n; ++i) trie.insert(sum[i]);
    int ans = 0;
    for(int i = 1; i <= n; ++i) ans = max(ans, trie.query(sum[i]));
    cout << ans << "\n";
    return 0;
}
