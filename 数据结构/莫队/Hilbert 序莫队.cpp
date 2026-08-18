#pragma once

#include "../../template/start.cpp"

struct HilbertMo {
    struct Query {
        int left, right, id;
        u64 order;
    };

    int power = 0, queryCount = 0;
    vector<Query> query;

    static u64 hilbertOrder(unsigned x, unsigned y, int power, int rotate = 0) {
        if(power == 0) return 0;
        unsigned half = 1u << (power - 1);
        int segment = x < half ? (y < half ? 0 : 3) : (y < half ? 1 : 2);
        segment = (segment + rotate) & 3;
        static const int rotateDelta[4] = {3, 0, 0, 1};
        unsigned mask = half - 1;
        u64 square = 1ULL << (2 * power - 2);
        u64 add = hilbertOrder(x & mask, y & mask, power - 1, (rotate + rotateDelta[segment]) & 3);
        return segment * square + ((segment == 1 || segment == 2) ? add : square - add - 1);
    }

    explicit HilbertMo(int n = 0)
        : power((int) bit_width((unsigned) (max(1, n) - 1))) {}

    int addQuery(int left, int right) {
        assert(1 <= left && left <= right);
        int id = queryCount++;
        query.push_back({left, right, id, hilbertOrder(left - 1, right - 1, power)});
        return id;
    }

    void work(auto&& add, auto&& del, auto&& answer) {
        ranges::sort(query, {}, &Query::order);
        int left = 1, right = 0;
        for(auto [ql, qr, id, order] : query) {
            while(left > ql) add(--left);
            while(right < qr) add(++right);
            while(left < ql) del(left++);
            while(right > qr) del(right--);
            answer(id);
        }
    }
};
