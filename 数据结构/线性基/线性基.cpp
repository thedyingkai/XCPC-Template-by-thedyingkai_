#include "../../template/start.cpp"

struct LinearBasis {
    static const int MAXB = 60;
    vector<i64> a;
    LinearBasis() : a(MAXB + 1, 0) {}
    void insert(i64 x) {
        for(int i = MAXB; i >= 0; --i) {
            if((x >> i) & 1) {
                if(!a[i]) {
                    a[i] = x;
                    return;
                }
                x ^= a[i];
            }
        }
    }
    bool can(i64 x) const {
        i64 cur = x;
        for(int i = MAXB; i >= 0; --i) {
            if((cur >> i) & 1) {
                if(!a[i]) return 0;
                cur ^= a[i];
            }
        }
        return 1;
    }
    i64 max_xor() const {
        i64 res = 0;
        for(int i = MAXB; i >= 0; --i)
            if((res ^ a[i]) > res) res ^= a[i];
        return res;
    }
    i64 min_xor() const { return 0; }
    i64 kth(i64 k) const {
        if(k <= 0) return -1;
        --k;
        vector<i64> base = a;
        vector<i64> simple;
        for(int i = 0; i <= MAXB; ++i) {
            for(int j = i - 1; j >= 0; --j)
                if((base[i] >> j) & 1) base[i] ^= base[j];
            if(base[i]) simple.push_back(base[i]);
        }
        int sz = simple.size();
        if(k >= (1ll << sz)) return -1;
        i64 res = 0;
        for(int i = 0; i < sz; ++i)
            if((k >> i) & 1) res ^= simple[i];
        return res;
    }
};
