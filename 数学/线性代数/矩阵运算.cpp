#ifndef XCPC_MATRIX
#define XCPC_MATRIX

#include "../../template/start.cpp"

template <class T> struct Matrix {
    static const int MOD = 1000000007;
    static constexpr bool _m_ = is_integral<T>::value; // 整数取模，浮点直接算
    int n, m;
    vector<vector<T>> rec;
    Matrix(int _n = 0, int _m = 0, T _x = 0) {
        n = _n, m = _m;
        rec.resize(_n, vector<T>(_m, _x));
    }
    vector<T>& operator[](int i) { return rec[i]; }
    const vector<T>& operator[](int i) const { return rec[i]; }
    // ---- 工具函数 ----
    static T norm(T v) {
        if constexpr(_m_) {
            i128 x = (i128) v % MOD;
            if(x < 0) x += MOD;
            return (T) x;
        } else
            return v;
    }
    static T add(T a, T b) {
        if constexpr(_m_) {
            i128 s = (i128) norm(a) + norm(b);
            if(s >= MOD) s -= MOD;
            return (T) s;
        } else
            return a + b;
    }
    static T sub(T a, T b) {
        if constexpr(_m_) {
            i128 d = (i128) norm(a) - norm(b);
            if(d < 0) d += MOD;
            return (T) d;
        } else
            return a - b;
    }
    static T mul(T a, T b) {
        if constexpr(_m_) {
            return (T) ((i128) norm(a) * norm(b) % MOD);
        } else
            return a * b;
    }
    static T modPow(T a, i64 e) {
        if constexpr(_m_) {
            T r = 1;
            T x = norm(a);
            while(e) {
                if(e & 1) r = mul(r, x);
                x = mul(x, x);
                e >>= 1;
            }
            return r;
        } else {
            T r = 1;
            while(e) {
                if(e & 1) r = r * a;
                a = a * a;
                e >>= 1;
            }
            return r;
        }
    }
    static T Inv(T a) {
        if constexpr(_m_)
            return modPow(a, MOD - 2);
        else
            return 1 / a;
    }
    static bool isZero(T v) {
        if constexpr(_m_)
            return norm(v) == 0;
        else {
            const d128 EPS = 1e-12;
            return fabsl((d128) v) < EPS;
        }
    }
    // ---- 矩阵乘法 ----
    friend Matrix operator*(const Matrix& a, const Matrix& b) {
        Matrix res(a.n, b.m);
        _rep(k, 0, a.m) _rep(i, 0, res.n) if(!isZero(a[i][k])) _rep(j, 0, res.m) res[i][j] =
            add(res[i][j], mul(a[i][k], b[k][j]));
        return res;
    }
    // ---- 快速幂 ----
    Matrix qp(Matrix base, i64 k) {
        Matrix res(base.n, base.m);
        _rep(i, 0, res.n) res[i][i] = 1;
        while(k) {
            if(k & 1) res = res * base;
            base = base * base;
            k >>= 1;
        }
        return res;
    }
    int Gauss(vector<vector<T>>* aug = 0, vector<int>* w = 0, T* det = 0);
    T det() const;
    Matrix inv() const;
    static pair<bool, vector<T>> solveLinear(Matrix A, vector<T> b);
    // ---- I/O ----
    friend ostream& operator<<(ostream& os, const Matrix& mat) {
        _rep(i, 0, mat.n) {
            _rep(j, 0, mat.m) os << mat[i][j] << " ";
            os << endl;
        }
        return os;
    }
    friend istream& operator>>(istream& is, Matrix& mat) {
        _rep(i, 0, mat.n) _rep(j, 0, mat.m) is >> mat[i][j];
        return is;
    }
};

#endif
