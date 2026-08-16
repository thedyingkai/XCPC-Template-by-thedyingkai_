#include "../../template/start.cpp"

struct LiChao {
    struct Line {
        i64 k, b;
        i128 get(i64 x) const { return (i128) k * x + b; }
    };
    struct Node {
        int ls, rs, line;
    };
    i64 L, R;
    int root;
    vector<Line> lines;
    vector<Node> tree;
    LiChao(i64 l, i64 r) : L(l), R(r), root(0), tree(1) {}
    int newNode() {
        tree.push_back({0, 0, -1});
        return (int) tree.size() - 1;
    }
    int insert(int u, i64 l, i64 r, int id) {
        if(!u) {
            u = newNode();
            tree[u].line = id;
            return u;
        }
        int cur = tree[u].line;
        if(lines[cur].k == lines[id].k) {
            if(lines[id].b > lines[cur].b) tree[u].line = id;
            return u;
        }
        i64 mid = l + (i64) (((i128) r - l) / 2);
        bool lef = lines[id].get(l) > lines[cur].get(l);
        bool cen = lines[id].get(mid) > lines[cur].get(mid);
        if(cen) swap(tree[u].line, id);
        if(l == r) return u;
        if(lef != cen) {
            int ch = insert(tree[u].ls, l, mid, id);
            tree[u].ls = ch;
        } else {
            int ch = insert(tree[u].rs, mid + 1, r, id);
            tree[u].rs = ch;
        }
        return u;
    }
    void addLine(i64 k, i64 b) {
        lines.push_back({k, b});
        root = insert(root, L, R, (int) lines.size() - 1);
    }
    i128 query(int u, i64 l, i64 r, i64 x) const {
        if(!u) return -((i128) 1 << 126);
        i128 ans = lines[tree[u].line].get(x);
        if(l == r) return ans;
        i64 mid = l + (i64) (((i128) r - l) / 2);
        if(x <= mid)
            return max(ans, query(tree[u].ls, l, mid, x));
        else
            return max(ans, query(tree[u].rs, mid + 1, r, x));
    }
    i128 query(i64 x) const {
        assert(L <= x && x <= R);
        return query(root, L, R, x);
    }
};
