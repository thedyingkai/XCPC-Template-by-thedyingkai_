#pragma once

#include "../../template/start.cpp"

template <i64 MOD = 998244353> struct LinearRecurrence {
    static_assert(MOD > 1);
    static i64 norm(i64 x) {
        x %= MOD;
        if(x < 0) x += MOD;
        return x;
    }

    static i64 qpow(i64 a, i64 e) {
        i64 r = 1;
        for(a = norm(a); e; e >>= 1, a = (i128) a * a % MOD)
            if(e & 1) r = (i128) r * a % MOD;
        return r;
    }

    static vector<i64> berlekampMassey(const vector<i64>& sequence) {
        vector<i64> s = sequence;
        for(i64& x : s) x = norm(x);
        vector<i64> C(1, 1), B(1, 1);
        int L = 0, shift = 1;
        i64 last = 1;
        for(int n = 0; n < (int) s.size(); n++) {
            i64 delta = s[n];
            for(int i = 1; i <= L; i++) delta = (delta + (i128) C[i] * s[n - i]) % MOD;
            if(delta == 0) {
                shift++;
                continue;
            }
            vector<i64> old = C;
            i64 coef = (i128) delta * qpow(last, MOD - 2) % MOD;
            if((int) C.size() < (int) B.size() + shift) C.resize(B.size() + shift);
            for(int i = 0; i < (int) B.size(); i++)
                C[i + shift] = norm(C[i + shift] - (i128) coef * B[i] % MOD);
            if(2 * L <= n) {
                L = n + 1 - L;
                B = old;
                last = delta;
                shift = 1;
            } else {
                shift++;
            }
        }
        C.resize(L + 1);
        vector<i64> recurrence(L);
        for(int i = 0; i < L; i++) recurrence[i] = norm(-C[i + 1]);
        return recurrence;
    }

    static vector<i64> combine(const vector<i64>& a, const vector<i64>& b,
                               const vector<i64>& recurrence) {
        int k = (int) recurrence.size();
        assert(k > 0 && (int) a.size() >= k && (int) b.size() >= k);
        vector<i64> left(k), right(k), coefficient(k);
        for(int i = 0; i < k; i++)
            left[i] = norm(a[i]), right[i] = norm(b[i]), coefficient[i] = norm(recurrence[i]);
        vector<i64> product(2 * k - 1);
        for(int i = 0; i < k; i++)
            for(int j = 0; j < k; j++)
                product[i + j] = (product[i + j] + (i128) left[i] * right[j]) % MOD;
        for(int i = 2 * k - 2; i >= k; i--)
            for(int j = 1; j <= k; j++)
                product[i - j] = (product[i - j] + (i128) product[i] * coefficient[j - 1]) % MOD;
        product.resize(k);
        return product;
    }

    static i64 nth(const vector<i64>& initial, const vector<i64>& recurrence, i64 n) {
        assert(n >= 0);
        if(n < (i64) initial.size()) return norm(initial[n]);
        int k = (int) recurrence.size();
        if(k == 0) return 0;
        assert((int) initial.size() >= k);
        vector<i64> answer(k), base(k);
        answer[0] = 1;
        if(k == 1)
            base[0] = norm(recurrence[0]);
        else
            base[1] = 1;
        while(n) {
            if(n & 1) answer = combine(answer, base, recurrence);
            base = combine(base, base, recurrence);
            n >>= 1;
        }
        i64 result = 0;
        for(int i = 0; i < k; i++) result = (result + (i128) answer[i] * norm(initial[i])) % MOD;
        return result;
    }
};
