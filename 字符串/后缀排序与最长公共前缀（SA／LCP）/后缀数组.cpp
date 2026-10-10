#include "../../template/start.cpp"

struct SA {
    int n;
    string s;
    vector<int> sa, rk, height;
    SA(const string& s_) { build(s_); }
    void build(const string& s_) {
        s = s_, n = s.size();
        sa.resize(n), rk.resize(n), height.assign(n, 0);
        if(n == 0) return;
        vector<int> x(n), y(n), cnt(max(n, 256));
        int m = 256;
        for(int i = 0; i < n; i++) x[i] = (unsigned char) s[i], cnt[x[i]]++;
        for(int i = 1; i < m; i++) cnt[i] += cnt[i - 1];
        for(int i = n - 1; i >= 0; i--) sa[--cnt[x[i]]] = i;
        for(int k = 1, p = 0; k < n; k <<= 1) {
            p = 0;
            for(int i = n - k; i < n; i++) y[p++] = i;
            for(int i = 0; i < n; i++)
                if(sa[i] >= k) y[p++] = sa[i] - k;
            fill(cnt.begin(), cnt.begin() + m, 0);
            for(int i = 0; i < n; i++) cnt[x[y[i]]]++;
            for(int i = 1; i < m; i++) cnt[i] += cnt[i - 1];
            for(int i = n - 1; i >= 0; i--) sa[--cnt[x[y[i]]]] = y[i];
            swap(x, y);
            x[sa[0]] = 0, p = 1;
            for(int i = 1; i < n; i++) {
                int a = sa[i - 1], b = sa[i];
                bool same =
                    y[a] == y[b] && ((a + k < n && b + k < n && y[a + k] == y[b + k]) || (a + k >= n && b + k >= n));
                x[b] = same ? p - 1 : p++;
            }
            if(p == n) break;
            m = p;
        }
        for(int i = 0; i < n; i++) rk[sa[i]] = i;
        for(int i = 0, k = 0; i < n; i++) {
            if(rk[i] == 0) continue;
            int j = sa[rk[i] - 1];
            while(i + k < n && j + k < n && s[i + k] == s[j + k]) k++;
            height[rk[i]] = k;
            if(k) k--;
        }
    }
};
