#include "../../template/start.cpp"

struct Manacher {
    string source, t;
    vector<int> p;
    Manacher(const string& s) : source(s) {
        int n = s.size();
        t.reserve(2 * n + 1);
        for(int i = 0; i < n; i++) t.push_back('#'), t.push_back(s[i]);
        t.push_back('#');
        int m = t.size();
        p.assign(m, 0);
        int c = 0, r = 0;
        for(int i = 0; i < m; i++) {
            int mir = 2 * c - i;
            if(i < r) p[i] = min(r - i, p[mir]);
            while(i - 1 - p[i] >= 0 && i + 1 + p[i] < m && t[i - 1 - p[i]] == t[i + 1 + p[i]]) p[i]++;
            if(i + p[i] > r) c = i, r = i + p[i];
        }
    }
    string longest() const {
        int best_len = 0, best_st = 0;
        for(int i = 0; i < (int) p.size(); i++) {
            int len = p[i];
            if(len == 0) continue;
            int st = (i - len) / 2;
            if(len > best_len || (len == best_len && st < best_st)) best_len = len, best_st = st;
        }
        if(best_len == 0) return source.empty() ? string() : string(1, source[0]);
        return source.substr(best_st, best_len);
    }
    bool is_pal(int l, int r) const {
        assert(0 <= l && l <= r && r <= (int) source.size());
        int len = r - l;
        if(len <= 0) return 0;
        int center_in_t = (len % 2 == 1) ? 2 * (l + len / 2) + 1 : 2 * l + len;
        return p[center_in_t] >= len;
    }
};
int main() {
    string s;
    getline(cin, s);
    Manacher M(s);
    cout << M.longest().length() << "\n";
    return 0;
}
