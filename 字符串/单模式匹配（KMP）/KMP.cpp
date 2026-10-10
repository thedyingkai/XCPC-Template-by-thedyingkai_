#include "../../template/start.cpp"

struct KMP {
    vector<int> nxt;
    string pat;
    KMP(const string& p) { build(p); }
    void build(const string& p) {
        pat = " " + p;
        int m = p.size();
        nxt.assign(m + 1, 0);
        for(int i = 2, j = 0; i <= m; i++) {
            while(j && pat[i] != pat[j + 1]) j = nxt[j];
            if(pat[i] == pat[j + 1]) j++;
            nxt[i] = j;
        }
    }
    vector<int> match(const string& txt) {
        string s = " " + txt;
        int n = txt.size(), m = pat.size() - 1;
        vector<int> pos;
        if(m == 0) return pos;
        for(int i = 1, j = 0; i <= n; i++) {
            while(j && s[i] != pat[j + 1]) j = nxt[j];
            if(s[i] == pat[j + 1]) j++;
            if(j == m) pos.push_back(i - m + 1), j = nxt[j];
        }
        return pos;
    }
};
int main() {
    string s1, s2;
    cin >> s1 >> s2;
    KMP kmp(s2);
    auto positions = kmp.match(s1);
    for(auto p : positions) cout << p << "\n";
    for(int i = 1; i < (int) kmp.nxt.size(); i++) cout << kmp.nxt[i] << " ";
    return 0;
}
