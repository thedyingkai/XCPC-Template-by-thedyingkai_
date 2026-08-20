#pragma once

#include "../../template/start.cpp"

struct MatroidOracle {
    // chosen 是当前公共独立集；元素编号为 0..n-1。
    virtual void reset(const vector<char>& chosen) = 0;
    virtual bool canAdd(int in) const = 0;
    virtual bool canExchange(int out, int in) const = 0;
    virtual ~MatroidOracle() = default;
};

template<class FirstOracle, class SecondOracle>
vector<int> matroidIntersection(int n, FirstOracle& first, SecondOracle& second) {
    vector<char> chosen(n, 0);

    // 任意公共独立集都能作为增广起点；先取一个极大集可减少增广轮数。
    first.reset(chosen), second.reset(chosen);
    for(int id = 0; id < n; id++) {
        if(first.canAdd(id) && second.canAdd(id)) {
            chosen[id] = 1;
            first.reset(chosen), second.reset(chosen);
        }
    }

    while(true) {
        first.reset(chosen), second.reset(chosen);
        vector<int> inside, outside;
        inside.reserve(n), outside.reserve(n);
        for(int id = 0; id < n; id++) {
            (chosen[id] ? inside : outside).push_back(id);
        }

        vector<int> pre(n, -2);
        vector<int> q;
        q.reserve(n);
        for(int y : outside) if(first.canAdd(y)) {
            pre[y] = -1;
            q.push_back(y);
        }
        int target = -1;
        for(int head = 0; head < (int) q.size() && target == -1; head++) {
            int v = q[head];
            if(!chosen[v]) {
                if(second.canAdd(v)) {
                    target = v;
                    break;
                }
                for(int x : inside) {
                    if(pre[x] == -2 && second.canExchange(x, v)) {
                        pre[x] = v;
                        q.push_back(x);
                    }
                }
            } else {
                for(int y : outside) {
                    if(pre[y] == -2 && first.canExchange(v, y)) {
                        pre[y] = v;
                        q.push_back(y);
                    }
                }
            }
        }
        if(target == -1) break;
        for(int v = target; v != -1; v = pre[v]) chosen[v] ^= 1;
    }
    vector<int> ans;
    for(int i = 0; i < n; i++) if(chosen[i]) ans.push_back(i);
    return ans;
}
