#include "../../template/start.cpp"

template <class T> struct Matrix {
    int n, m;
    vector<vector<T>> rec;
    Matrix(int n = 0, int m = 0, T value = T{}) : n(n), m(m), rec(n, vector<T>(m, value)) {}
    vector<T>& operator[](int i) { return rec[i]; }
    const vector<T>& operator[](int i) const { return rec[i]; }
    friend Matrix operator*(const Matrix& a, const Matrix& b) {
        Matrix res(a.n, b.m);
        _rep(k, 0, a.m) _rep(i, 0, res.n) _rep(j, 0, res.m)
            res[i][j] += a[i][k] * b[k][j];
        return res;
    }
    static Matrix qp(Matrix base, i64 k) {
        Matrix res(base.n, base.m);
        _rep(i, 0, res.n) res[i][i] = 1;
        while(k) {
            if(k & 1) res = res * base;
            base = base * base;
            k >>= 1;
        }
        return res;
    }
};
