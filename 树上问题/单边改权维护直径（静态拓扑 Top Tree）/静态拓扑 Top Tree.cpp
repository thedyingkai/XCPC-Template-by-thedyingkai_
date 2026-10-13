#pragma once

#include "../../template/start.cpp"

struct TopTree {
    enum class Type { Leaf, Rake, Compress };

    struct Edge {
        int u = -1;
        int v = -1;
        i64 w = 0;
    };

    struct Info {
        i64 len = 0;
        i64 lmax = 0;
        i64 rmax = 0;
        i64 diameter = 0;
    };

    struct Node {
        int child[2] = {-1, -1};
        int fa = -1;
        int boundary[2] = {-1, -1};
        Type type = Type::Leaf;
    };

    int rt = -1;
    vector<Edge> edges;
    vector<Node> tr;
    vector<Info> val;

    TopTree() = default;

    TopTree(
        int n,
        const vector<Edge>& es,
        int root = 0
    ) {
        build(n, es, root);
    }

    static Info makeEdge(i64 w) {
        return {w, w, w, w};
    }

    static Info rake(const Info& main, const Info& side) {
        Info result;
        result.len = main.len;
        result.lmax = max(main.lmax, side.lmax);
        result.rmax = max(main.rmax, main.len + side.lmax);
        result.diameter = max({
            main.diameter,
            side.diameter,
            main.lmax + side.lmax
        });
        return result;
    }

    static Info compress(const Info& left, const Info& right) {
        Info result;
        result.len = left.len + right.len;
        result.lmax = max(left.lmax, left.len + right.lmax);
        result.rmax = max(right.rmax, right.len + left.rmax);
        result.diameter = max({
            left.diameter,
            right.diameter,
            left.rmax + right.lmax
        });
        return result;
    }

    void build(int n, const vector<Edge>& es, int root = 0) {
        edges = es;

        vector<vector<pair<int, int>>> g(n);
        for(int id = 0; id < n - 1; id++) {
            const auto& edge = edges[id];
            g[edge.u].push_back({edge.v, id});
            g[edge.v].push_back({edge.u, id});
        }

        vector<int> fa(n, -2), pe(n, -1), order;
        order.reserve(n);
        fa[root] = -1;
        order.push_back(root);
        for(int i = 0; i < order.size(); i++) {
            int u = order[i];
            for(auto [v, id] : g[u]) {
                if(v == fa[u]) continue;
                fa[v] = u;
                pe[v] = id;
                order.push_back(v);
            }
        }

        vector<int> sz(n, 1), son(n, -1);
        for(int i = n - 1; i >= 0; i--) {
            int u = order[i];
            int mx = 0;
            for(auto [v, id] : g[u]) {
                (void)id;
                if(fa[v] != u) continue;
                sz[u] += sz[v];
                if(sz[v] > mx) {
                    mx = sz[v];
                    son[u] = v;
                }
            }
        }

        tr.assign(n, Node{});
        val.assign(n, Info{});
        vector<int> leaf(n - 1, -1);
        for(int u = 0; u < n; u++) {
            tr[u].boundary[0] = fa[u];
            tr[u].boundary[1] = u;
            i64 w = 0;
            if(pe[u] != -1) {
                leaf[pe[u]] = u;
                w = edges[pe[u]].w;
            }
            val[u] = makeEdge(w);
        }

        auto mergeNode = [&](int left, int right, Type type) {
            Node node;
            node.child[0] = left;
            node.child[1] = right;
            node.type = type;
            if(type == Type::Rake) {
                node.boundary[0] = tr[left].boundary[0];
                node.boundary[1] = tr[left].boundary[1];
            } else {
                node.boundary[0] = tr[left].boundary[0];
                node.boundary[1] = tr[right].boundary[1];
            }
            int merged = tr.size();
            tr.push_back(node);
            val.push_back(Info{});
            tr[left].fa = merged;
            tr[right].fa = merged;
            return merged;
        };

        auto pullNode = [&](int node) {
            int left = tr[node].child[0];
            int right = tr[node].child[1];
            if(tr[node].type == Type::Rake) {
                val[node] = rake(val[left], val[right]);
            } else {
                val[node] = compress(val[left], val[right]);
            }
        };

        auto buildPath = [&](auto&& self, int head) -> pair<int, int> {
            vector<int> path;
            for(int u = head; u != -1; u = son[u]) {
                path.push_back(u);
            }

            vector<pair<int, int>> stack;
            stack.push_back({0, path[0]});

            auto mergeLast = [&]() {
                auto [rh, right] = stack.back();
                stack.pop_back();
                auto [lh, left] = stack.back();
                stack.pop_back();
                int merged = mergeNode(left, right, Type::Compress);
                pullNode(merged);
                stack.push_back({max(lh, rh) + 1, merged});
            };

            for(int i = 1; i < path.size(); i++) {
                int p = path[i - 1];
                int main = path[i];
                priority_queue<
                    pair<int, int>,
                    vector<pair<int, int>>,
                    greater<pair<int, int>>
                > q;
                q.push({0, main});
                for(auto [v, id] : g[p]) {
                    (void)id;
                    if(fa[v] != p || v == son[p]) continue;
                    q.push(self(self, v));
                }

                while(q.size() >= 2) {
                    auto [lh, left] = q.top();
                    q.pop();
                    auto [rh, right] = q.top();
                    q.pop();
                    if(right == main) {
                        swap(lh, rh);
                        swap(left, right);
                    }
                    int merged = mergeNode(left, right, Type::Rake);
                    pullNode(merged);
                    if(left == main) main = merged;
                    q.push({max(lh, rh) + 1, merged});
                }

                stack.push_back(q.top());
                while(true) {
                    int size = stack.size();
                    if(
                        size >= 3 &&
                        (stack[size - 3].first == stack[size - 2].first ||
                         stack[size - 3].first <= stack[size - 1].first)
                    ) {
                        auto last = stack.back();
                        stack.pop_back();
                        mergeLast();
                        stack.push_back(last);
                    } else if(size >= 2 && stack[size - 2].first <= stack[size - 1].first) {
                        mergeLast();
                    } else {
                        break;
                    }
                }
            }

            while(stack.size() >= 2) mergeLast();
            return stack.back();
        };

        rt = buildPath(buildPath, root).second;
        pos = move(leaf);
    }

    void setEdge(int id, i64 w) {
        edges[id].w = w;
        int node = pos[id];
        val[node] = makeEdge(w);
        for(node = tr[node].fa; node != -1; node = tr[node].fa) {
            int left = tr[node].child[0];
            int right = tr[node].child[1];
            if(tr[node].type == Type::Rake) {
                val[node] = rake(val[left], val[right]);
            } else {
                val[node] = compress(val[left], val[right]);
            }
        }
    }

    const Info& all() const {
        return val[rt];
    }

    i64 diameter() const {
        return all().diameter;
    }

private:
    vector<int> pos;
};
