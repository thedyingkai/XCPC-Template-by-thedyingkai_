#include "../../template/start.cpp"

struct Min25Sieve {
    using PrimePower = function<i64(i64, int, i64)>;

    i64 n, mod;
    int root;
    array<i64, 3> coefficient;
    PrimePower primePower;
    vector<i64> primes, value;
    vector<int> smallId, largeId;
    array<vector<i64>, 3> g, primePrefix;
    vector<i64> primeValuePrefix;

    Min25Sieve(i64 n_, i64 mod_, array<i64, 3> coefficient_, PrimePower primePower_)
        : n(n_), mod(mod_), coefficient(coefficient_), primePower(move(primePower_)) {
        assert(n >= 1 && mod >= 1);
        build();
    }

    i64 norm(i128 x) const {
        x %= mod;
        if(x < 0) x += mod;
        return (i64)x;
    }

    i64 add(i64 a, i64 b) const {
        return norm((i128)a + b);
    }

    i64 sub(i64 a, i64 b) const {
        return norm((i128)a - b);
    }

    i64 mul(i64 a, i64 b) const {
        return (i64)((i128)a * b % mod);
    }

    i64 sumPower0(i64 x) const {
        return norm((i128)x - 1);
    }

    i64 sumPower1(i64 x) const {
        i128 a = x, b = (i128)x + 1;
        if(a % 2 == 0) a /= 2;
        else b /= 2;
        return sub(mul(norm(a), norm(b)), 1 % mod);
    }

    i64 sumPower2(i64 x) const {
        array<i128, 3> factor = {x, (i128)x + 1, (i128)2 * x + 1};
        for(i128 d : {2, 3}) {
            for(i128& v : factor) {
                if(v % d == 0) {
                    v /= d;
                    break;
                }
            }
        }
        i64 ans = 1 % mod;
        for(i128 v : factor) ans = mul(ans, norm(v));
        return sub(ans, 1 % mod);
    }

    int getId(i64 x) const {
        assert(1 <= x && x <= n);
        int id = x <= root ? smallId[(int)x] : largeId[(int)(n / x)];
        assert(id >= 0);
        return id;
    }

    i64 polynomialAt(i64 p) const {
        i64 x = norm(p), x2 = mul(x, x);
        i64 ans = mul(norm(coefficient[0]), 1 % mod);
        ans = add(ans, mul(norm(coefficient[1]), x));
        ans = add(ans, mul(norm(coefficient[2]), x2));
        return ans;
    }

    void buildPrimes() {
        vector<char> isComposite(root + 1, 0);
        for(int i = 2; i <= root; ++i) {
            if(!isComposite[i]) primes.push_back(i);
            for(i64 p : primes) {
                if((i64)i * p > root) break;
                isComposite[(int)(i * p)] = 1;
                if(i % p == 0) break;
            }
        }
    }

    void build() {
        i64 rt = (i64)sqrtl((long double)n);
        while(rt + 1 <= n / (rt + 1)) ++rt;
        while(rt > n / rt) --rt;
        assert(rt <= INT_MAX);
        root = (int)rt;
        buildPrimes();

        smallId.assign(root + 1, -1);
        largeId.assign(root + 1, -1);
        for(i64 l = 1, r; l <= n; l = r + 1) {
            i64 x = n / l;
            r = n / x;
            int id = (int)value.size();
            value.push_back(x);
            if(x <= root) smallId[(int)x] = id;
            else largeId[(int)(n / x)] = id;
            if(r == n) break;
        }

        for(auto& v : g) v.resize(value.size());
        for(int id = 0; id < (int)value.size(); ++id) {
            i64 x = value[id];
            g[0][id] = sumPower0(x);
            g[1][id] = sumPower1(x);
            g[2][id] = sumPower2(x);
        }

        for(auto& v : primePrefix) v.assign(primes.size() + 1, 0);
        primeValuePrefix.assign(primes.size() + 1, 0);
        for(int i = 0; i < (int)primes.size(); ++i) {
            i64 p = primes[i], pm = norm(p);
            array<i64, 3> pk = {1 % mod, pm, mul(pm, pm)};
            for(int k = 0; k < 3; ++k)
                primePrefix[k][i + 1] = add(primePrefix[k][i], pk[k]);
            primeValuePrefix[i + 1] = add(primeValuePrefix[i], polynomialAt(p));
        }

        for(int i = 0; i < (int)primes.size(); ++i) {
            i64 p = primes[i];
            if(p > n / p) break;
            i64 pm = norm(p);
            array<i64, 3> pk = {1 % mod, pm, mul(pm, pm)};
            i64 p2 = p * p;
            for(int id = 0; id < (int)value.size() && value[id] >= p2; ++id) {
                int nextId = getId(value[id] / p);
                for(int k = 0; k < 3; ++k) {
                    i64 removed = mul(pk[k], sub(g[k][nextId], primePrefix[k][i]));
                    g[k][id] = sub(g[k][id], removed);
                }
            }
        }
    }

    i64 primeSum(i64 x) const {
        if(x < 2) return 0;
        int id = getId(x);
        i64 ans = 0;
        for(int k = 0; k < 3; ++k)
            ans = add(ans, mul(norm(coefficient[k]), g[k][id]));
        return ans;
    }

    i64 dfs(i64 x, int firstPrime) const {
        if(x < 2) return 0;
        if(firstPrime > 0 && primes[firstPrime - 1] > x) return 0;
        i64 ans = sub(primeSum(x), primeValuePrefix[firstPrime]);
        for(int i = firstPrime; i < (int)primes.size(); ++i) {
            i64 p = primes[i];
            if(p > x / p) break;
            i64 pe = p;
            for(int e = 1; pe <= x / p; ++e) {
                i64 fpe = norm(primePower(p, e, norm(pe)));
                i64 nextPe = pe * p;
                i64 fnext = norm(primePower(p, e + 1, norm(nextPe)));
                ans = add(ans, mul(fpe, dfs(x / pe, i + 1)));
                ans = add(ans, fnext);
                pe = nextPe;
            }
        }
        return ans;
    }

    // Returns sum_{i=1}^n f(i), with f(1)=1.
    i64 solve() const {
        return add(1 % mod, dfs(n, 0));
    }
};
