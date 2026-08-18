#include "../../template/start.cpp"

struct Lyndon {
    // 返回 Lyndon 分解的 0 下标半开区间 [l, r)。
    static vector<pair<int, int>> factorize(const string& s) {
        vector<pair<int, int>> factors;
        int n = (int) s.size();
        for(int i = 0; i < n;) {
            int j = i + 1, k = i;
            while(j < n && (unsigned char) s[k] <= (unsigned char) s[j]) {
                k = ((unsigned char) s[k] < (unsigned char) s[j] ? i : k + 1);
                j++;
            }
            int len = j - k;
            while(i <= k) {
                factors.push_back({i, i + len});
                i += len;
            }
        }
        return factors;
    }

    // 返回字典序最小循环表示的最小起点；空串返回 0。
    static int min_rotation(const string& source) {
        int n = (int) source.size();
        if(n == 0) return 0;
        string s = source + source;
        int i = 0, ans = 0;
        while(i < n) {
            ans = i;
            int j = i + 1, k = i;
            while(j < 2 * n && (unsigned char) s[k] <= (unsigned char) s[j]) {
                k = ((unsigned char) s[k] < (unsigned char) s[j] ? i : k + 1);
                j++;
            }
            int len = j - k;
            while(i <= k) i += len;
        }
        return ans;
    }
};
