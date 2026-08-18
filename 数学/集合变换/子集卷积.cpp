#pragma once

#include "集合变换.cpp"

struct SubsetConvolution {
    static vector<i64> multiply(const vector<i64>& a, const vector<i64>& b) {
        assert(a.size() == b.size());
        int n = (int) a.size(), bits = SetTransform::bitsOf(n);
        vector<vector<i64>> A(bits + 1, vector<i64>(n));
        vector<vector<i64>> B(bits + 1, vector<i64>(n));
        vector<vector<i64>> C(bits + 1, vector<i64>(n));
        for(int s = 0; s < n; s++) {
            int c = popcount((unsigned) s);
            A[c][s] = SetTransform::norm(a[s]);
            B[c][s] = SetTransform::norm(b[s]);
        }
        for(int c = 0; c <= bits; c++) {
            SetTransform::subsetZeta(A[c]);
            SetTransform::subsetZeta(B[c]);
        }
        for(int c = 0; c <= bits; c++)
            for(int x = 0; x <= c; x++)
                for(int s = 0; s < n; s++)
                    C[c][s] = (C[c][s] + A[x][s] * B[c - x][s]) % SetTransform::MOD;
        for(int c = 0; c <= bits; c++) SetTransform::subsetZeta(C[c], true);
        vector<i64> ans(n);
        for(int s = 0; s < n; s++) ans[s] = C[popcount((unsigned) s)][s];
        return ans;
    }
};
