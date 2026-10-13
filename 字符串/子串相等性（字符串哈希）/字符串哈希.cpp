#include "../../template/start.cpp"

struct StringHash {
    static constexpr int MOD1 = 1000000007;
    static constexpr int MOD2 = 1000000009;
    static constexpr int BASE = 13331;
    int n;
    vector<int> p1, p2, h1, h2;
    StringHash(const string& s) {
        n = s.size();
        p1.resize(n + 1), p2.resize(n + 1);
        h1.resize(n + 1), h2.resize(n + 1);
        p1[0] = p2[0] = 1;
        for(int i = 0; i < n; i++) {
            int c = (unsigned char) s[i] + 1;
            p1[i + 1] = (i64) p1[i] * BASE % MOD1;
            p2[i + 1] = (i64) p2[i] * BASE % MOD2;
            h1[i + 1] = ((i64) h1[i] * BASE + c) % MOD1;
            h2[i + 1] = ((i64) h2[i] * BASE + c) % MOD2;
        }
    }
    pair<int, int> get(int l, int r) const {
        int x = (h1[r] - (i64) h1[l] * p1[r - l]) % MOD1;
        int y = (h2[r] - (i64) h2[l] * p2[r - l]) % MOD2;
        if(x < 0) x += MOD1;
        if(y < 0) y += MOD2;
        return {x, y};
    }
};
