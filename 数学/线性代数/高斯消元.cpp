#ifndef XCPC_GAUSS
#define XCPC_GAUSS

#include "矩阵运算.cpp"

template <class T>
int Matrix<T>::Gauss(vector<vector<T>>* aug, vector<int>* w, T* det) {
    if(w) w->assign(m, -1);
    if(det) *det = 1;
    int rank = 0;
    for(int c = 0, r = 0; c < m && r < n; c++) {
        int idx = -1;
        d128 best = 0;
        for(int i = r; i < n; i++) if(!isZero(rec[i][c])) {
            if constexpr(_m_) {
                idx = i;
                break;
            } else if(fabsl((d128) rec[i][c]) > best) {
                best = fabsl((d128) rec[i][c]);
                idx = i;
            }
        }
        if(idx == -1) continue;
        if(idx != r) {
            swap(rec[idx], rec[r]);
            if(aug) swap((*aug)[idx], (*aug)[r]);
            if(det) *det = sub(0, *det);
        }
        if(det) *det = mul(*det, rec[r][c]);
        T inv = Inv(rec[r][c]);
        for(int j = c; j < m; j++) rec[r][j] = mul(rec[r][j], inv);
        if(aug)
            for(auto& v : (*aug)[r]) v = mul(v, inv);
        for(int i = 0; i < n; i++) if(i != r && !isZero(rec[i][c])) {
            T k = rec[i][c];
            for(int j = c; j < m; j++) rec[i][j] = sub(rec[i][j], mul(k, rec[r][j]));
            if(aug)
                for(int j = 0; j < (int) (*aug)[i].size(); j++)
                    (*aug)[i][j] = sub((*aug)[i][j], mul(k, (*aug)[r][j]));
        }
        if(w) (*w)[c] = r;
        rank++, r++;
    }
    if(det && rank < min(n, m)) *det = 0;
    return rank;
}

#endif
