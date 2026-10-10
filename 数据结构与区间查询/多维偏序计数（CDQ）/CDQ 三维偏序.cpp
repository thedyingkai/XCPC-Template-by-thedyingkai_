#pragma once

#include "../../template/start.cpp"

struct CDQDominance {
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

    struct Node {
        i64 x, y, z;
        int compressedZ, weight;
        i64 answer = 0;
        vector<int> ids;
    };

    vector<Node> point, buffer;
    Fenwick bit;

    void solve(int left, int right) {
        if(right - left <= 1) return;
        int middle = (left + right) >> 1;
        solve(left, middle);
        solve(middle, right);
        int i = left, j = middle, p = left;
        vector<pair<int, int>> added;
        while(j < right) {
            while(i < middle && point[i].y <= point[j].y) {
                bit.add(point[i].compressedZ, point[i].weight);
                added.push_back({point[i].compressedZ, point[i].weight});
                buffer[p++] = move(point[i++]);
            }
            point[j].answer += bit.query(point[j].compressedZ);
            buffer[p++] = move(point[j++]);
        }
        while(i < middle) buffer[p++] = move(point[i++]);
        for(auto [z, weight] : added) bit.add(z, -weight);
        while(j < right) buffer[p++] = move(point[j++]);
        for(int k = left; k < right; k++) point[k] = move(buffer[k]);
    }

    vector<i64> count(const vector<array<i64, 3>>& input) {
        int n = (int) input.size();
        vector<array<i64, 4>> raw(n);
        vector<i64> allZ;
        for(int i = 0; i < n; i++) {
            raw[i] = {input[i][0], input[i][1], input[i][2], i};
            allZ.push_back(input[i][2]);
        }
        sort(raw.begin(), raw.end(), [](const auto& a, const auto& b) {
            return tie(a[0], a[1], a[2]) < tie(b[0], b[1], b[2]);
        });
        sort(allZ.begin(), allZ.end());
        allZ.erase(unique(allZ.begin(), allZ.end()), allZ.end());
        point.clear();
        for(int i = 0; i < n;) {
            int j = i;
            Node node{raw[i][0], raw[i][1], raw[i][2], 0, 0, 0, {}};
            while(j < n && raw[j][0] == node.x && raw[j][1] == node.y && raw[j][2] == node.z) {
                node.ids.push_back((int) raw[j][3]);
                node.weight++;
                j++;
            }
            node.compressedZ = (int) (lower_bound(allZ.begin(), allZ.end(), node.z) - allZ.begin()) + 1;
            node.answer = node.weight - 1;
            point.push_back(move(node));
            i = j;
        }
        buffer.resize(point.size());
        bit = Fenwick((int) allZ.size());
        solve(0, (int) point.size());
        vector<i64> answer(n);
        for(const auto& node : point)
            for(int id : node.ids) answer[id] = node.answer;
        return answer;
    }
};
