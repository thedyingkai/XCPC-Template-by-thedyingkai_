#include "../后缀数组/后缀数组.cpp"

struct Runs {
    struct Run {
        int l, r, p;
        auto operator<=>(const Run&) const = default;
    };

    struct LCE {
        int n, base;
        SA suffix;
        vector<int> seg;

        LCE(const string& s) : n((int) s.size()), base(1), suffix(s) {
            base = (int) bit_ceil((unsigned) max(n, 1));
            seg.assign(2 * base, INT_MAX);
            for(int i = 0; i < n; i++) seg[base + i] = suffix.height[i];
            for(int i = base - 1; i; i--) seg[i] = min(seg[i << 1], seg[i << 1 | 1]);
        }

        int range_min(int l, int r) const {
            int ans = INT_MAX;
            for(l += base, r += base; l < r; l >>= 1, r >>= 1) {
                if(l & 1) ans = min(ans, seg[l++]);
                if(r & 1) ans = min(ans, seg[--r]);
            }
            return ans;
        }

        int lcp(int i, int j) const {
            if(i == j) return n - i;
            int a = suffix.rk[i], b = suffix.rk[j];
            if(a > b) swap(a, b);
            return range_min(a + 1, b + 1);
        }
    };

    static vector<int> next_smaller_suffix(const vector<int>& rank) {
        int n = (int) rank.size();
        vector<int> next(n, n), st;
        st.reserve(n);
        for(int i = n - 1; i >= 0; i--) {
            while(!st.empty() && rank[st.back()] > rank[i]) st.pop_back();
            if(!st.empty()) next[i] = st.back();
            st.push_back(i);
        }
        return next;
    }

    static vector<Run> enumerate(const string& s) {
        int n = (int) s.size();
        if(n < 2) return {};

        LCE right(s);
        string reversed(s.rbegin(), s.rend());
        LCE left(reversed);

        string opposite = s;
        for(char& c : opposite) c = char(255 - (unsigned char) c);
        SA opposite_suffix(opposite);

        vector<Run> runs;
        auto collect = [&](const vector<int>& rank) {
            vector<int> next = next_smaller_suffix(rank);
            for(int i = 0; i < n; i++) {
                int j = next[i];
                if(j == n) continue;
                int p = j - i;
                int extend_left = (i == 0 ? 0 : left.lcp(n - i, n - j));
                if(extend_left >= p) continue;
                int extend_right = right.lcp(i, j);
                int l = i - extend_left, r = j + extend_right;
                if(r - l >= 2 * p) runs.push_back({l, r, p});
            }
        };

        collect(right.suffix.rk);
        collect(opposite_suffix.rk);
        sort(runs.begin(), runs.end());
        runs.erase(unique(runs.begin(), runs.end()), runs.end());
        return runs;
    }
};
