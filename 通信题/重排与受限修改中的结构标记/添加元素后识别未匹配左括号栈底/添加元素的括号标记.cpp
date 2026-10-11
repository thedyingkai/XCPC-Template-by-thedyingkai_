#pragma once
#include <bits/stdc++.h>
namespace communication {

// 原集合大小严格小于 n/2；true 为集合内元素。
// 返回要加入的 0-based 元素编号。
int bracket_element_to_add(const std::vector<bool> &member) {
    int n = member.size();
    int count = std::count(member.begin(), member.end(), true);
    if (2LL * count >= n)
        throw std::invalid_argument("set must be smaller than n/2");
    int balance = 0, last_unmatched_right = -1;
    for (int i = 0; i < n; ++i) {
        if (member[i]) ++balance;
        else if (balance) --balance;
        else last_unmatched_right = i;
    }
    return last_unmatched_right;
}

// 新集合的未匹配左括号栈底，恰为新增元素。
int decode_added_bracket_element(const std::vector<bool> &member) {
    std::vector<int> stack;
    for (int i = 0; i < int(member.size()); ++i)
        if (member[i]) stack.push_back(i);
        else if (!stack.empty()) stack.pop_back();
    if (stack.empty())
        throw std::invalid_argument("missing added marker");
    return stack.front();
}

} // namespace communication
