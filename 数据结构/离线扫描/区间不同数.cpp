#pragma once

#include "../../template/start.cpp"

struct OfflineDistinct {
    struct Fenwick {
        vector<int> tree;
        explicit Fenwick(int n = 0) : tree(n + 1) {}
        void add(int x, int value) {
            for(; x < (int) tree.size(); x += x & -x) tree[x] += value;
        }
        int query(int x) const {
            int result = 0;
            for(; x; x -= x & -x) result += tree[x];
            return result;
        }
    };

    static vector<int> count(const vector<i64>& a, const vector<pair<int, int>>& query) {
        int n = (int) a.size(), q = (int) query.size();
        vector<vector<pair<int, int>>> atRight(n + 1);
        for(int id = 0; id < q; id++) {
            auto [left, right] = query[id];
            assert(1 <= left && left <= right && right <= n);
            atRight[right].push_back({left, id});
        }
        Fenwick bit(n);
        map<i64, int> last;
        vector<int> answer(q);
        for(int right = 1; right <= n; right++) {
            i64 value = a[right - 1];
            if(last.count(value)) bit.add(last[value], -1);
            bit.add(right, 1);
            last[value] = right;
            for(auto [left, id] : atRight[right]) answer[id] = bit.query(right) - bit.query(left - 1);
        }
        return answer;
    }
};
