#include "../../template/start.cpp"

struct ArbitraryModComb {
    struct PrimePower {
        i64 p, mod;
        int exponent;
        vector<i64> prefix;

        static i64 power(i64 a, i64 e, i64 mod) {
            i64 res = 1 % mod;
            while(e > 0) {
                if(e & 1) res = (i128) res * a % mod;
                a = (i128) a * a % mod;
                e >>= 1;
            }
            return res;
        }

        i64 factorialWithoutP(i64 n) const {
            if(n == 0) return 1;
            i64 res = power(prefix[mod], n / mod, mod);
            res = (i128) res * prefix[n % mod] % mod;
            return (i128) res * factorialWithoutP(n / p) % mod;
        }

        i64 countP(i64 n) const {
            i64 res = 0;
            while(n > 0) n /= p, res += n;
            return res;
        }

        i64 C(i64 n, i64 k) const {
            if(k < 0 || k > n) return 0;
            i64 e = countP(n) - countP(k) - countP(n - k);
            if(e >= exponent) return 0;
            i64 a = factorialWithoutP(n);
            i64 b = factorialWithoutP(k);
            i64 c = factorialWithoutP(n - k);
            i64 den = (i128) b * c % mod;
            i64 inv = inverse(den, mod);
            return (i128) a * inv % mod * power(p, e, mod) % mod;
        }

        static i128 exgcd(i128 a, i128 b, i128& x, i128& y) {
            if(b == 0) {
                x = 1, y = 0;
                return a;
            }
            i128 x1, y1;
            i128 g = exgcd(b, a % b, x1, y1);
            x = y1;
            y = x1 - a / b * y1;
            return g;
        }

        static i64 inverse(i64 a, i64 mod) {
            i128 x, y;
            exgcd(a, mod, x, y);
            x %= mod;
            if(x < 0) x += mod;
            return (i64) x;
        }
    };

    i64 mod = 1;
    vector<PrimePower> parts;

    void init(i64 arbitrary_mod) {
        assert(arbitrary_mod >= 1);
        mod = arbitrary_mod;
        parts.clear();
        if(mod <= 1) return;
        i64 x = mod;
        for(i64 p = 2; p <= x / p; p += (p == 2 ? 1 : 2)) {
            if(x % p != 0) continue;
            i64 pk = 1;
            int q = 0;
            while(x % p == 0) x /= p, pk *= p, q++;
            addPrimePower(p, pk, q);
        }
        if(x > 1) addPrimePower(x, x, 1);
    }

    i64 C(i64 n, i64 k) const {
        if(mod == 1 || k < 0 || k > n) return 0;
        i64 ans = 0, current_mod = 1;
        for(const auto& part : parts) {
            i64 residue = part.C(n, k);
            i64 rhs = (residue - ans) % part.mod;
            if(rhs < 0) rhs += part.mod;
            i64 inv = PrimePower::inverse(current_mod % part.mod, part.mod);
            i64 step = (i128) rhs * inv % part.mod;
            i128 next = (i128) ans + (i128) current_mod * step;
            current_mod *= part.mod;
            ans = (i64) (next % current_mod);
        }
        return ans;
    }

private:
    void addPrimePower(i64 p, i64 pk, int q) {
        PrimePower part{p, pk, q, vector<i64>(pk + 1, 1)};
        for(i64 i = 1; i <= pk; i++) {
            part.prefix[i] = part.prefix[i - 1];
            if(i % p != 0) part.prefix[i] = (i128) part.prefix[i] * i % pk;
        }
        parts.push_back(move(part));
    }
};
