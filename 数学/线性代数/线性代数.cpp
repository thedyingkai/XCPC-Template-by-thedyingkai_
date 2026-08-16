#ifndef XCPC_LINEAR_ALGEBRA
#define XCPC_LINEAR_ALGEBRA

#include "高斯消元.cpp"

template <class T>
T Matrix<T>::det() const {
    if(n != m) return 0;
    Matrix tmp = *this;
    T ans;
    tmp.Gauss(0, 0, &ans);
    return ans;
}

template <class T>
Matrix<T> Matrix<T>::inv() const {
    if(n != m) return Matrix();
    vector<vector<T>> aug(n, vector<T>(n, 0));
    for(int i = 0; i < n; i++) aug[i][i] = 1;
    Matrix A = *this;
    if(A.Gauss(&aug) < n) return Matrix();
    Matrix res(n, n);
    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++) res[i][j] = aug[i][j];
    return res;
}

template <class T>
pair<bool, vector<T>> Matrix<T>::solveLinear(Matrix<T> A, vector<T> b) {
    int n = A.n, m = A.m;
    if((int) b.size() != n) {
        cout << "No Solution" << endl;
        return {};
    }
    vector<vector<T>> col(n, vector<T>(1));
    for(int i = 0; i < n; i++) col[i][0] = b[i];
    vector<int> w;
    int rank = A.Gauss(&col, &w);
    for(int i = rank; i < n; i++) if(!isZero(col[i][0])) return {0, {}};
    vector<T> x(m, 0);
    for(int i = 0; i < m; i++) if(w[i] != -1) x[i] = col[w[i]][0];
    if(rank < m) return {0, {}};
    return {1, x};
}

#endif
