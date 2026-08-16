#include "../../template/start.cpp"

struct Mo {
    struct Query {
        int l, r, id;
    };
    int block, tot;
    vector<Query> q;
    Mo(int n) : block(max(1, (int) sqrt(n))), tot(0) {}
    int addQuery(int l, int r) {
        q.push_back({l, r, tot});
        return tot++;
    }
    template <class Add, class Del, class Answer> void work(Add&& add, Del&& del, Answer&& answer) {
        sort(q.begin(), q.end(), [&](const Query& a, const Query& b) {
            int x = (a.l - 1) / block, y = (b.l - 1) / block;
            if(x != y) return x < y;
            return x & 1 ? a.r > b.r : a.r < b.r;
        });
        int l = 1, r = 0;
        for(auto [ql, qr, id] : q) {
            while(l > ql) add(--l);
            while(r < qr) add(++r);
            while(l < ql) del(l++);
            while(r > qr) del(r--);
            answer(id);
        }
    }
};
