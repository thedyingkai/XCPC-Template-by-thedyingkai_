#pragma once

#include "../../template/start.cpp"

struct OverallKth {
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
        int query(int l, int r) const { return query(r) - query(l - 1); }
    };

    struct Event {
        int type;
        int position, delta;
        int left, right, kth, id;
        i64 value;
        int rank = -1;
    };

    int n, queryCount = 0;
    vector<i64> current, values, answer;
    vector<Event> event, buffer;
    Fenwick bit;

    explicit OverallKth(const vector<i64>& initial) : n((int) initial.size()), current(n + 1), bit(n) {
        for(int i = 1; i <= n; i++) {
            current[i] = initial[i - 1];
            values.push_back(current[i]);
            event.push_back({0, i, 1, 0, 0, 0, 0, current[i]});
        }
    }

    void change(int position, i64 value) {
        assert(1 <= position && position <= n);
        event.push_back({0, position, -1, 0, 0, 0, 0, current[position]});
        event.push_back({0, position, 1, 0, 0, 0, 0, value});
        current[position] = value;
        values.push_back(value);
    }

    int addQuery(int left, int right, int kth) {
        assert(1 <= left && left <= right && right <= n && 1 <= kth && kth <= right - left + 1);
        int id = queryCount++;
        event.push_back({1, 0, 0, left, right, kth, id, 0});
        return id;
    }

    void divide(int valueLeft, int valueRight, int eventLeft, int eventRight) {
        if(eventLeft >= eventRight) return;
        if(valueLeft == valueRight) {
            for(int i = eventLeft; i < eventRight; i++)
                if(event[i].type == 1) answer[event[i].id] = values[valueLeft];
            return;
        }
        int valueMiddle = (valueLeft + valueRight) >> 1;
        int leftCount = 0;
        vector<char> goLeft(eventRight - eventLeft);
        for(int i = eventLeft; i < eventRight; i++) {
            auto& e = event[i];
            if(e.type == 0) {
                if(e.rank <= valueMiddle) {
                    bit.add(e.position, e.delta);
                    goLeft[i - eventLeft] = true;
                    leftCount++;
                }
            } else {
                int count = bit.query(e.left, e.right);
                if(count >= e.kth) {
                    goLeft[i - eventLeft] = true;
                    leftCount++;
                }
                else e.kth -= count;
            }
        }
        int pLeft = eventLeft, pRight = eventLeft + leftCount;
        for(int i = eventLeft; i < eventRight; i++) {
            auto& e = event[i];
            bool side = goLeft[i - eventLeft];
            if(e.type == 0 && side) bit.add(e.position, -e.delta);
            buffer[side ? pLeft++ : pRight++] = move(e);
        }
        for(int i = eventLeft; i < eventRight; i++) event[i] = move(buffer[i]);
        divide(valueLeft, valueMiddle, eventLeft, eventLeft + leftCount);
        divide(valueMiddle + 1, valueRight, eventLeft + leftCount, eventRight);
    }

    vector<i64> solve() {
        sort(values.begin(), values.end());
        values.erase(unique(values.begin(), values.end()), values.end());
        for(auto& e : event)
            if(e.type == 0)
                e.rank = (int) (lower_bound(values.begin(), values.end(), e.value) - values.begin());
        answer.assign(queryCount, 0);
        buffer.resize(event.size());
        if(!event.empty()) divide(0, (int) values.size() - 1, 0, (int) event.size());
        return answer;
    }
};
