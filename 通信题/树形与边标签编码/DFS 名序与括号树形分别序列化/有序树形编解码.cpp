#pragma once
#include <bits/stdc++.h>
namespace communication {

struct OrderedTreeCode {
    std::vector<int> preorder;
    std::string brackets; // 1 进入，0 离开，共 2n 位。
};

OrderedTreeCode encode_ordered_tree(
    const std::vector<std::vector<int>> &children, int root) {
    int n = children.size();
    if (root < 0 || root >= n)
        throw std::invalid_argument("invalid root");
    OrderedTreeCode code;
    std::vector<std::pair<int, bool>> stack{{root, true}};
    std::vector<bool> seen(n);
    while (!stack.empty()) {
        auto [u, enter] = stack.back();
        stack.pop_back();
        code.brackets += enter ? '1' : '0';
        if (!enter) continue;
        if (u < 0 || u >= n || seen[u])
            throw std::invalid_argument("not a rooted tree");
        seen[u] = true;
        code.preorder.push_back(u);
        stack.push_back({u, false});
        for (auto it = children[u].rbegin();
             it != children[u].rend(); ++it)
            stack.push_back({*it, true});
    }
    if (int(code.preorder.size()) != n)
        throw std::invalid_argument("unreachable vertex");
    return code;
}

struct DecodedOrderedTree {
    int root;
    std::vector<std::vector<int>> children;
};

// 传输的名称若为 1..n，外层先减一；preorder 是 0..n-1 的排列。
DecodedOrderedTree decode_ordered_tree(const OrderedTreeCode &code) {
    int n = code.preorder.size(), next = 0, root = -1;
    if (!n || code.brackets.size() != 2ULL * n)
        throw std::invalid_argument("invalid tree code length");
    std::vector<std::vector<int>> children(n);
    std::vector<int> stack;
    std::vector<bool> seen(n);
    for (char bit : code.brackets) {
        if (bit == '1') {
            if (next == n)
                throw std::invalid_argument("too many open brackets");
            int u = code.preorder[next++];
            if (u < 0 || u >= n || seen[u])
                throw std::invalid_argument("invalid name order");
            seen[u] = true;
            if (stack.empty()) {
                if (root != -1)
                    throw std::invalid_argument("multiple roots");
                root = u;
            } else children[stack.back()].push_back(u);
            stack.push_back(u);
        } else if (bit == '0' && !stack.empty()) stack.pop_back();
        else throw std::invalid_argument("unbalanced tree code");
    }
    if (!stack.empty() || next != n)
        throw std::invalid_argument("unbalanced tree code");
    return {root, std::move(children)};
}

} // namespace communication
