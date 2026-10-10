#pragma once

#include "../../template/start.cpp"

// start: sparse-table
template <class T, class Op> struct SparseTable {
    int n = 0;
    Op op;
    vector<int> lg;
    vector<vector<T>> table;

    SparseTable() = default;
    explicit SparseTable(const vector<T>& a, Op op_ = Op()) : op(op_) { build(a); }

    void build(const vector<T>& a) {
        n = (int) a.size();
        lg.assign(n + 1, 0);
        for(int i = 2; i <= n; i++) lg[i] = lg[i >> 1] + 1;
        table.assign(n ? lg[n] + 1 : 0, vector<T>(n));
        if(!n) return;
        table[0] = a;
        for(int k = 1; (1 << k) <= n; k++)
            for(int i = 0; i + (1 << k) <= n; i++)
                table[k][i] = op(table[k - 1][i], table[k - 1][i + (1 << (k - 1))]);
    }

    T query(int l, int r) const {
        assert(0 <= l && l <= r && r < n);
        int k = lg[r - l + 1];
        return op(table[k][l], table[k][r - (1 << k) + 1]);
    }
};
// end: sparse-table

// start: disjoint-sparse-table
template <class T, class Op> struct DisjointSparseTable {
    int n = 0, levels = 0;
    Op op;
    vector<T> value;
    vector<vector<T>> table;

    DisjointSparseTable() = default;
    explicit DisjointSparseTable(const vector<T>& a, Op op_ = Op()) : op(op_) { build(a); }

    void build(const vector<T>& a) {
        value = a;
        n = (int) a.size();
        levels = n <= 1 ? 0 : (int) bit_width((unsigned) (n - 1));
        table.assign(levels, vector<T>(n));
        for(int k = 0; k < levels; k++) {
            int half = 1 << k, length = half << 1;
            for(int left = 0; left < n; left += length) {
                int middle = min(left + half, n), right = min(left + length, n);
                if(middle == left || middle == right) continue;
                table[k][middle - 1] = a[middle - 1];
                for(int i = middle - 2; i >= left; i--)
                    table[k][i] = op(a[i], table[k][i + 1]);
                table[k][middle] = a[middle];
                for(int i = middle + 1; i < right; i++)
                    table[k][i] = op(table[k][i - 1], a[i]);
            }
        }
    }

    T query(int l, int r) const {
        assert(0 <= l && l <= r && r < n);
        if(l == r) return value[l];
        int k = (int) bit_width((unsigned) (l ^ r)) - 1;
        return op(table[k][l], table[k][r]);
    }
};
// end: disjoint-sparse-table
