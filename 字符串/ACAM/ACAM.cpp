#include <template/start.cpp>

struct AC {
    struct Node {
        int son[26], ans, fail, du, idx;
        void init() {
            memset(son, 0, sizeof son);
            ans = fail = idx = du = 0;
        }
    };
    vector<Node> tr;
    vector<int> ans; // 最终每个模式串出现次数
    int tot, pidx;   // 节点总数，模式串编号计数器
    AC(int n) {
        tr.resize(n + 1);
        ans.resize(n + 1);
        tot = pidx = 0;
        tr[0].init();
    }
    // 插入模式串，返回该模式串编号
    void insert(const string& s, int& idx) {
        int u = 0;
        for(int i = 0; i < s.size(); i++) {
            int c = s[i] - 'a';
            if(!tr[u].son[c]) {
                tr[u].son[c] = ++tot;
                tr[tot].init();
            }
            u = tr[u].son[c];
        }
        if(!tr[u].idx) tr[u].idx = ++pidx;
        idx = tr[u].idx;
    }
    // 建立fail指针
    void build() {
        queue<int> q;
        for(int i = 0; i < 26; i++)
            if(tr[0].son[i]) q.push(tr[0].son[i]);
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int i = 0; i < 26; i++) {
                if(tr[u].son[i]) {
                    tr[tr[u].son[i]].fail = tr[tr[u].fail].son[i];
                    tr[tr[tr[u].fail].son[i]].du++;
                    q.push(tr[u].son[i]);
                } else
                    tr[u].son[i] = tr[tr[u].fail].son[i];
            }
        }
    }
    // 在文本串中查询所有模式串出现次数
    void query(const string& t) {
        int u = 0;
        for(int i = 0; i < t.size(); i++) u = tr[u].son[t[i] - 'a'], tr[u].ans++;
    }
    // 拓扑排序，累计模式串出现次数
    void topu() {
        queue<int> q;
        for(int i = 0; i <= tot; i++)
            if(tr[i].du == 0) q.push(i);
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            ans[tr[u].idx] = tr[u].ans;
            int v = tr[u].fail;
            tr[v].ans += tr[u].ans;
            if(--tr[v].du == 0) q.push(v);
        }
    }
};

void main() {
    int n;
    cin >> n;
    AC ac(2e5);
    vector<int> idx(n + 1);
    for(int i = 1; i <= n; i++) {
        string s;
        cin >> s;
        ac.insert(s, idx[i]);
    }
    string text;
    cin >> text;
    ac.build();
    ac.query(text);
    ac.topu();
    for(int i = 1; i <= n; i++) cout << ac.ans[idx[i]] << "\n";
}
