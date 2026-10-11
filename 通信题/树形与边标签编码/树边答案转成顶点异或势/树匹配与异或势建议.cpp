#pragma once
#include <bits/stdc++.h>
namespace communication {

struct TreeMatchingAdvice {
    int matching_size = 0;
    std::vector<int> vertex_bit, parent;
    std::vector<bool> chosen_parent_edge;
};

// graph 为无向树，编号 0..n-1，根固定为 0。
// 子树后序贪心选择最大匹配；根势为 0，无需传输。
TreeMatchingAdvice tree_matching_advice(
    const std::vector<std::vector<int>> &graph) {
    int n = graph.size();
    if (!n) throw std::invalid_argument("empty tree");
    TreeMatchingAdvice result;
    result.parent.assign(n, -1);
    result.vertex_bit.assign(n, 0);
    result.chosen_parent_edge.assign(n, false);
    result.parent[0] = 0;
    std::vector<int> order{0};
    for (int i = 0; i < int(order.size()); ++i) {
        int u = order[i];
        for (int v : graph[u])
            if (result.parent[v] == -1) {
                result.parent[v] = u;
                order.push_back(v);
            }
    }
    if (int(order.size()) != n)
        throw std::invalid_argument("tree must be connected");
    std::vector<bool> matched(n);
    for (int i = n - 1; i > 0; --i) {
        int u = order[i], p = result.parent[u];
        if (!matched[u] && !matched[p]) {
            matched[u] = matched[p] = true;
            result.chosen_parent_edge[u] = true;
            ++result.matching_size;
        }
    }
    for (int i = 1; i < n; ++i) {
        int u = order[i];
        result.vertex_bit[u] =
            result.vertex_bit[result.parent[u]]
            ^ int(result.chosen_parent_edge[u]);
    }
    return result;
}

// 接收端仅用端点标签即可回答边是否属于选定匹配。
bool advised_tree_edge(int label_u, int label_v) {
    return bool(label_u ^ label_v);
}

} // namespace communication
