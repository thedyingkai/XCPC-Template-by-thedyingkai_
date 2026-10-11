#pragma once
#include <bits/stdc++.h>
namespace communication {

// 树点编号 0..n-1；偶深进入时编号，奇深离开时编号。
std::vector<int> station_labels(
    const std::vector<std::vector<int>> &tree, int root = 0) {
    int n = tree.size(), timer = 0;
    if (root < 0 || root >= n)
        throw std::invalid_argument("invalid root");
    struct Event { int u, parent, depth; bool enter; };
    std::vector<Event> stack{{root, -1, 0, true}};
    std::vector<int> label(n, -1);
    std::vector<bool> seen(n);
    while (!stack.empty()) {
        auto [u, parent, depth, enter] = stack.back();
        stack.pop_back();
        if (!enter) {
            if (depth % 2) label[u] = timer++;
            continue;
        }
        if (u < 0 || u >= n || seen[u])
            throw std::invalid_argument("not a tree");
        seen[u] = true;
        if (!(depth % 2)) label[u] = timer++;
        stack.push_back({u, parent, depth, false});
        for (auto it = tree[u].rbegin(); it != tree[u].rend(); ++it)
            if (*it != parent)
                stack.push_back({*it, u, depth + 1, true});
    }
    if (timer != n) throw std::invalid_argument("disconnected tree");
    return label;
}

// neighbors 已按标签递增排序；返回下一跳的标签。
int route_station(int current, int target,
                  const std::vector<int> &neighbors) {
    if (current == target) return current;
    if (neighbors.empty() ||
        !std::is_sorted(neighbors.begin(), neighbors.end()))
        throw std::invalid_argument("invalid neighbor labels");
    if (current < neighbors.front()) {
        if (target < current) return neighbors.back();
        auto it = std::lower_bound(neighbors.begin(), neighbors.end(),
                                   target);
        return it == neighbors.end() ? neighbors.back() : *it;
    }
    if (current > neighbors.back()) {
        if (target > current) return neighbors.front();
        auto it = std::upper_bound(neighbors.begin(), neighbors.end(),
                                   target);
        return it == neighbors.begin() ? neighbors.front() : *--it;
    }
    throw std::invalid_argument("labels violate alternating DFS");
}

} // namespace communication
