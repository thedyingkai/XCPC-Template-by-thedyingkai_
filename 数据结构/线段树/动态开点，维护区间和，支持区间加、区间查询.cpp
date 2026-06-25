#include <template/start.cpp>

template <class T> struct Node {
    Node *ls, *rs;
    int l, r;
    T val, tag;
    Node(int L, int R) : l(L), r(R), val(0), tag(0) { ls = rs = nullptr; }
    void pushup() { val = ls->val + rs->val; }
    bool inRange(int L, int R) { return L <= l && r <= R; }
    bool outRange(int L, int R) { return r < L || R < l; }
    inline void makeTag(T x) {
        val += (r - l + 1) * x;
        tag += x;
    }
    inline void pushdown() {
        if(!ls) {
            int mid = (l + r) >> 1;
            ls = new Node(l, mid);
            rs = new Node(mid + 1, r);
        }
        if(tag) {
            ls->makeTag(tag);
            rs->makeTag(tag);
            tag = 0;
        }
    }
    void update(int L, int R, T k) {
        if(inRange(L, R))
            makeTag(k);
        else if(!outRange(L, R)) {
            pushdown();
            ls->update(L, R, k);
            rs->update(L, R, k);
            pushup();
        }
    }
    T query(int L, int R) {
        if(inRange(L, R))
            return val;
        else if(outRange(L, R))
            return 0;
        else {
            pushdown();
            return ls->query(L, R) + rs->query(L, R);
        }
    }
};
int main() {
    int n, q;
    cin >> n >> q;
    auto st = new Node<u64>(1, n);
    while(q--) {
        u64 op, l, r;
        cin >> op >> l >> r;
        if(op == 1) {
            u64 k;
            cin >> k;
            st->update(l, r, k);
        } else
            cout << st->query(l, r) + (r - l + 1) * (r + l) / 2 << endl;
    }
}
