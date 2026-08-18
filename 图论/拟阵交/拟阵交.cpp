#pragma once

#include "../../template/start.cpp"

struct MatroidOracle {
    // chosen 是当前公共独立集；元素编号为 0..n-1。
    virtual void reset(const vector<char>& chosen) = 0;
    virtual bool canAdd(int in) const = 0;
    virtual bool canExchange(int out, int in) const = 0;
    virtual ~MatroidOracle() = default;
};

vector<int> matroidIntersection(int n, MatroidOracle& first, MatroidOracle& second) {
    vector<char> chosen(n, 0);
    while(true) {
        first.reset(chosen), second.reset(chosen);
        vector<int> pre(n, -2);
        queue<int> q;
        for(int y = 0; y < n; y++) if(!chosen[y] && first.canAdd(y)) {
            pre[y] = -1;
            q.push(y);
        }
        int target = -1;
        while(!q.empty() && target == -1) {
            int v = q.front();
            q.pop();
            if(!chosen[v]) {
                if(second.canAdd(v)) {
                    target = v;
                    break;
                }
                for(int x = 0; x < n; x++) {
                    if(chosen[x] && pre[x] == -2 && second.canExchange(x, v)) {
                        pre[x] = v;
                        q.push(x);
                    }
                }
            } else {
                for(int y = 0; y < n; y++) {
                    if(!chosen[y] && pre[y] == -2 && first.canExchange(v, y)) {
                        pre[y] = v;
                        q.push(y);
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
