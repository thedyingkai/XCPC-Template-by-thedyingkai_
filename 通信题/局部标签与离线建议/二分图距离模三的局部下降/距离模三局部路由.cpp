#pragma once
#include <bits/stdc++.h>
namespace communication {

// 连通无权二分图；颜色 0,1,2 对应 r,g,b。
std::vector<int> mod3_colors(
    const std::vector<std::vector<int>> &graph, int root = 0) {
    int n = graph.size();
    if (root < 0 || root >= n)
        throw std::invalid_argument("invalid root");
    std::vector<int> distance(n, -1);
    std::queue<int> queue;
    distance[root] = 0;
    queue.push(root);
    while (!queue.empty()) {
        int u = queue.front(); queue.pop();
        for (int v : graph[u]) {
            if (distance[v] == -1) {
                distance[v] = distance[u] + 1;
                queue.push(v);
            } else if ((distance[u] - distance[v]) % 2 == 0)
                throw std::invalid_argument("graph is not bipartite");
        }
    }
    for (int &d : distance) {
        if (d == -1) throw std::invalid_argument("disconnected graph");
        d %= 3;
    }
    return distance;
}

// 当前点尚未到根；返回邻居列表中的 0-based 位置。
int route_colors(const std::vector<int> &colors) {
    unsigned mask = 0;
    for (int color : colors) {
        if (color < 0 || color > 2)
            throw std::invalid_argument("invalid color");
        mask |= 1u << color;
    }
    if (!mask || mask == 7)
        throw std::invalid_argument("invalid local color pattern");
    int chosen = mask == 3 ? 1 : mask == 6 ? 2 : mask == 5 ? 0
                                                        : std::countr_zero(mask);
    return std::find(colors.begin(), colors.end(), chosen)
         - colors.begin();
}

} // namespace communication
