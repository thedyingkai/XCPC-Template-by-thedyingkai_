#include "../../template/start.cpp"

template <class T> struct Matrix {
    int n, m;
    vector<vector<T>> rec;
    Matrix(int n_ = 0, int m_ = 0, T value = T{}) : n(n_), m(m_) {
        assert(n >= 0 && m >= 0);
        rec.assign(n, vector<T>(m, value));
    }
    vector<T>& operator[](int i) { return rec[i]; }
    const vector<T>& operator[](int i) const { return rec[i]; }
    friend Matrix operator*(const Matrix& a, const Matrix& b) {
        assert(a.m == b.n);
        Matrix res(a.n, b.m);
        for(int k = 0; k < a.m; k++)
            for(int i = 0; i < res.n; i++)
                for(int j = 0; j < res.m; j++) res[i][j] += a[i][k] * b[k][j];
        return res;
    }
    static Matrix qp(Matrix base, i64 k) {
        assert(base.n == base.m && k >= 0);
        Matrix res(base.n, base.m);
        for(int i = 0; i < res.n; i++) res[i][i] = 1;
        while(k) {
            if(k & 1) res = res * base;
            base = base * base;
            k >>= 1;
        }
        return res;
    }
};
