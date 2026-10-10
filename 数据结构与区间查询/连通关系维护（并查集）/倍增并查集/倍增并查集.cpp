#pragma once
#include "../../../template/start.cpp"

struct RangeUnionDSU {
    int n, levels, components;
    vector<vector<int>> parent, size;

    explicit RangeUnionDSU(int n_) : n(n_), components(n_) {
        assert(n >= 1);
        levels = (int) bit_width((unsigned) n);
        parent.assign(levels, vector<int>(n + 1));
        size.assign(levels, vector<int>(n + 1, 1));
        for(auto& row : parent) iota(row.begin(), row.end(), 0);
    }

    int find(int level, int x) {
        while(x != parent[level][x]) {
            parent[level][x] = parent[level][parent[level][x]];
            x = parent[level][x];
        }
        return x;
    }

    void mergeBlock(int level, int x, int y) {
        int rx = find(level, x), ry = find(level, y);
        if(rx == ry) return;
        if(size[level][rx] < size[level][ry]) swap(rx, ry);
        parent[level][ry] = rx;
        size[level][rx] += size[level][ry];
        if(level == 0) { components--; return; }
        int half = 1 << (level - 1);
        mergeBlock(level - 1, x, y);
        mergeBlock(level - 1, x + half, y + half);
    }

    // Merge x+i with y+i, for 0 <= i < length (overlap is allowed).
    void uniteRanges(int x, int y, int length) {
        assert(length >= 0 && 1 <= x && 1 <= y);
        assert((i64) x + length <= (i64) n + 1);
        assert((i64) y + length <= (i64) n + 1);
        if(length == 0) return;
        int level = (int) bit_width((unsigned) length) - 1;
        int shift = length - (1 << level);
        mergeBlock(level, x, y);
        mergeBlock(level, x + shift, y + shift);
    }

    bool same(int x, int y) {
        assert(1 <= x && x <= n && 1 <= y && y <= n);
        return find(0, x) == find(0, y);
    }
};
