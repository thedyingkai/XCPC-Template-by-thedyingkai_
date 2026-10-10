#include "../../template/start.cpp"

struct DujiaoSieve {
    int limit = 0;
    vector<int> primes, mu, phi;
    vector<char> isComposite;
    vector<i64> prefixMu;
    vector<i128> prefixPhi;
    unordered_map<i64, i64> memoMu;
    unordered_map<i64, i128> memoPhi;

    void init(int n) {
        assert(n >= 1);
        limit = n;
        primes.clear();
        mu.assign(n + 1, 0);
        phi.assign(n + 1, 0);
        isComposite.assign(n + 1, 0);
        prefixMu.assign(n + 1, 0);
        prefixPhi.assign(n + 1, 0);
        memoMu.clear();
        memoPhi.clear();
        mu[1] = phi[1] = 1;
        for(int i = 2; i <= n; ++i) {
            if(!isComposite[i]) {
                primes.push_back(i);
                mu[i] = -1;
                phi[i] = i - 1;
            }
            for(int p : primes) {
                if((i64)i * p > n) break;
                isComposite[i * p] = 1;
                if(i % p == 0) {
                    mu[i * p] = 0;
                    phi[i * p] = phi[i] * p;
                    break;
                }
                mu[i * p] = -mu[i];
                phi[i * p] = phi[i] * (p - 1);
            }
        }
        for(int i = 1; i <= n; ++i) {
            prefixMu[i] = prefixMu[i - 1] + mu[i];
            prefixPhi[i] = prefixPhi[i - 1] + phi[i];
        }
    }

    i64 sumMu(i64 n) {
        assert(n >= 0 && limit >= 1);
        if(n <= limit) return prefixMu[(int)n];
        if(auto it = memoMu.find(n); it != memoMu.end()) return it->second;
        i128 ans = 1;
        for(i64 l = 2, r; l <= n; l = r + 1) {
            i64 q = n / l;
            r = n / q;
            ans -= (i128)(r - l + 1) * sumMu(q);
            if(r == n) break;
        }
        return memoMu[n] = (i64)ans;
    }

    i128 sumPhi(i64 n) {
        assert(n >= 0 && limit >= 1);
        if(n <= limit) return prefixPhi[(int)n];
        if(auto it = memoPhi.find(n); it != memoPhi.end()) return it->second;
        i128 ans = (i128)n * ((i128)n + 1) / 2;
        for(i64 l = 2, r; l <= n; l = r + 1) {
            i64 q = n / l;
            r = n / q;
            ans -= (i128)(r - l + 1) * sumPhi(q);
            if(r == n) break;
        }
        return memoPhi[n] = ans;
    }
};
