#include <template/start.cpp>

struct SAM {
    struct state {
        int len, link;                 // len：该状态对应的最长子串长度，link：后缀链接
        unordered_map<char, int> next; // 状态转移边，字符->下一个状态编号
    };
    int sz, last;     // sz：状态总数，last：当前最后加入的状态
    vector<state> st; // 状态数组
    SAM(int n) {
        st.resize(2 * n + 2); // 最多2n-1个状态，留足空间
        st[0].len = 0;        // 初始状态长度为0
        st[0].link = -1;      // 初始状态无后缀链接
        sz = 1;               // 当前状态个数为1（初始状态）
        last = 0;             // 当前最后状态为0
    }
    // 插入字符c，返回新加入的状态编号
    int extend(char c) {
        int cur = sz++;                 // 新状态编号
        st[cur].len = st[last].len + 1; // 新状态最长子串长度为上一个状态+1
        int p = last;
        // 从last开始沿后缀链接寻找没c转移的状态，建立转移到cur
        while(p != -1 && !st[p].next.count(c)) st[p].next[c] = cur, p = st[p].link;
        if(p == -1)
            st[cur].link = 0; // 找不到后缀链接，连接到初始状态0
        else {
            int q = st[p].next[c];
            if(st[p].len + 1 == st[q].len)
                st[cur].link = q; // 情况1：直接连接q
            else {                // 情况2：需要克隆状态q
                int clone = sz++;
                st[clone].len = st[p].len + 1;
                st[clone].next = st[q].next;
                st[clone].link = st[q].link;
                // 调整p及其后缀链接中指向q的转移改为clone
                while(p != -1 && st[p].next[c] == q) st[p].next[c] = clone, p = st[p].link;
                st[q].link = st[cur].link = clone; // q和cur的后缀链接指向clone
            }
        }
        last = cur; // 更新last为当前状态
        return cur;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    string s;
    cin >> s;
    SAM sam((int) s.size()); // 初始化SAM结构，长度为字符串长度
    vector<int> nodes;       // 保存每次插入字符对应的状态编号
    for(auto c : s) nodes.push_back(sam.extend(c));
    int sz = sam.sz;
    vector<vector<int>> g(sz); // 建树，link作为父指针，子指针存储在这里
    for(int i = 1; i < sz; i++) g[sam.st[i].link].push_back(i);
    vector<int> cnt(sz);          // 计数每个状态对应子串出现次数
    for(auto x : nodes) cnt[x]++; // 每个插入状态出现一次
    i64 ans = 0;                  // 结果变量，最长重复子串出现次数*长度的最大值
    // 后序遍历，累加子树中出现次数，更新答案
    function<void(int)> dfs = [&](int u) {
        for(auto v : g[u]) {
            dfs(v);
            cnt[u] += cnt[v];
        }
        if(cnt[u] >= 2) ans = max(ans, (i64) cnt[u] * sam.st[u].len);
    };
    dfs(0);              // 从根状态0开始dfs
    cout << ans << '\n'; // 输出答案
    return 0;
}
