#pragma once

#include "../../template/start.cpp"

struct SetTransform {
    static constexpr i64 MOD = 998244353;

    static i64 norm(i64 x) {
        x %= MOD;
        if(x < 0) x += MOD;
        return x;
    }

    static int bitsOf(int n) {
        return (int) bit_width((unsigned) n) - 1;
    }

    static void subsetZeta(vector<i64>& a, bool inverse = false) {
        int n = a.size(), bits = bitsOf(n);
        for(i64& x : a) x = norm(x);
        for(int bit = 0; bit < bits; bit++)
            for(int s = 0; s < n; s++)
                if(s >> bit & 1) {
                    i64& x = a[s];
                    i64 y = a[s ^ (1 << bit)];
                    x = inverse ? norm(x - y) : norm(x + y);
                }
    }

    static void supersetZeta(vector<i64>& a, bool inverse = false) {
        int n = a.size(), bits = bitsOf(n);
        for(i64& x : a) x = norm(x);
        for(int bit = 0; bit < bits; bit++)
            for(int s = 0; s < n; s++)
                if(!(s >> bit & 1)) {
                    i64& x = a[s];
                    i64 y = a[s | (1 << bit)];
                    x = inverse ? norm(x - y) : norm(x + y);
                }
    }

    static void xorTransform(vector<i64>& a, bool inverse = false) {
        int n = a.size();
        bitsOf(n);
        const i64 inv2 = (MOD + 1) / 2;
        for(i64& x : a) x = norm(x);
        for(int len = 1; len < n; len <<= 1)
            for(int l = 0; l < n; l += len << 1)
                for(int i = 0; i < len; i++) {
                    i64 x = a[l + i], y = a[l + i + len];
                    a[l + i] = norm(x + y);
                    a[l + i + len] = norm(x - y);
                    if(inverse) {
                        a[l + i] = a[l + i] * inv2 % MOD;
                        a[l + i + len] = a[l + i + len] * inv2 % MOD;
                    }
                }
    }

    static vector<i64> orConvolution(vector<i64> a, vector<i64> b) {
        subsetZeta(a);
        subsetZeta(b);
        for(int i = 0; i < a.size(); i++) a[i] = a[i] * b[i] % MOD;
        subsetZeta(a, true);
        return a;
    }

    static vector<i64> andConvolution(vector<i64> a, vector<i64> b) {
        supersetZeta(a);
        supersetZeta(b);
        for(int i = 0; i < a.size(); i++) a[i] = a[i] * b[i] % MOD;
        supersetZeta(a, true);
        return a;
    }

    static vector<i64> xorConvolution(vector<i64> a, vector<i64> b) {
        xorTransform(a);
        xorTransform(b);
        for(int i = 0; i < a.size(); i++) a[i] = a[i] * b[i] % MOD;
        xorTransform(a, true);
        return a;
    }
};
