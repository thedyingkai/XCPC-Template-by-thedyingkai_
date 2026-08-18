#pragma once

#include "../../../template/start.cpp"

struct StaticTopologyTopTreeDiameter {
    enum class MergeType { Leaf, Rake, Compress };

    struct Edge {
        int from = -1;
        int to = -1;
        i64 weight = 0;
    };

    struct Cluster {
        i64 length = 0;
        i64 fromLeft = 0;
        i64 fromRight = 0;
        i64 diameter = 0;
    };

    struct Node {
        int child[2] = {-1, -1};
        int parent = -1;
        int boundary[2] = {-1, -1};
        MergeType type = MergeType::Leaf;
    };

    int vertexCount = 0;
    int rootVertex = -1;
    int rootCluster = -1;
    vector<Edge> edges;
    vector<Node> nodes;
    vector<Cluster> value;

    StaticTopologyTopTreeDiameter() = default;

    StaticTopologyTopTreeDiameter(
        int n,
        const vector<Edge>& treeEdges,
        int root = 0
    ) {
        build(n, treeEdges, root);
    }

    static Cluster makeEdge(i64 weight) {
        assert(weight >= 0);
        return {weight, weight, weight, weight};
    }

    static Cluster rake(const Cluster& main, const Cluster& side) {
        Cluster result;
        result.length = main.length;
        result.fromLeft = max(main.fromLeft, side.fromLeft);
        result.fromRight = max(main.fromRight, main.length + side.fromLeft);
        result.diameter = max({
            main.diameter,
            side.diameter,
            main.fromLeft + side.fromLeft
        });
        return result;
    }

    static Cluster compress(const Cluster& left, const Cluster& right) {
        Cluster result;
        result.length = left.length + right.length;
        result.fromLeft = max(left.fromLeft, left.length + right.fromLeft);
        result.fromRight = max(right.fromRight, right.length + left.fromRight);
        result.diameter = max({
            left.diameter,
            right.diameter,
            left.fromRight + right.fromLeft
        });
        return result;
    }

    void build(int n, const vector<Edge>& treeEdges, int root = 0) {
        assert(n >= 1);
        assert(0 <= root && root < n);
        assert(static_cast<int>(treeEdges.size()) == n - 1);
        vertexCount = n;
        rootVertex = root;
        edges = treeEdges;

        vector<vector<pair<int, int>>> graph(n);
        for(int id = 0; id < n - 1; id++) {
            const auto& edge = edges[id];
            assert(0 <= edge.from && edge.from < n);
            assert(0 <= edge.to && edge.to < n);
            assert(edge.from != edge.to);
            assert(edge.weight >= 0);
            graph[edge.from].push_back({edge.to, id});
            graph[edge.to].push_back({edge.from, id});
        }

        vector<int> parent(n, -2), parentEdge(n, -1), order;
        order.reserve(n);
        parent[root] = -1;
        order.push_back(root);
        for(int index = 0; index < static_cast<int>(order.size()); index++) {
            int vertex = order[index];
            for(auto [next, edgeId] : graph[vertex]) {
                if(next == parent[vertex]) continue;
                assert(parent[next] == -2);
                parent[next] = vertex;
                parentEdge[next] = edgeId;
                order.push_back(next);
            }
        }
        assert(static_cast<int>(order.size()) == n);

        vector<int> subtreeSize(n, 1), heavyChild(n, -1);
        for(int index = n - 1; index >= 0; index--) {
            int vertex = order[index];
            int largestSize = 0;
            for(auto [next, edgeId] : graph[vertex]) {
                (void)edgeId;
                if(parent[next] != vertex) continue;
                subtreeSize[vertex] += subtreeSize[next];
                if(subtreeSize[next] > largestSize) {
                    largestSize = subtreeSize[next];
                    heavyChild[vertex] = next;
                }
            }
        }

        nodes.assign(n, Node{});
        value.assign(n, Cluster{});
        vector<int> edgeLeaf(n - 1, -1);
        for(int vertex = 0; vertex < n; vertex++) {
            nodes[vertex].boundary[0] = parent[vertex];
            nodes[vertex].boundary[1] = vertex;
            i64 weight = 0;
            if(parentEdge[vertex] != -1) {
                edgeLeaf[parentEdge[vertex]] = vertex;
                weight = edges[parentEdge[vertex]].weight;
            }
            value[vertex] = makeEdge(weight);
        }

        auto mergeNode = [&](int left, int right, MergeType type) {
            assert(left != -1 && right != -1);
            Node node;
            node.child[0] = left;
            node.child[1] = right;
            node.type = type;
            if(type == MergeType::Rake) {
                assert(nodes[left].boundary[0] == nodes[right].boundary[0]);
                node.boundary[0] = nodes[left].boundary[0];
                node.boundary[1] = nodes[left].boundary[1];
            } else {
                assert(type == MergeType::Compress);
                assert(nodes[left].boundary[1] == nodes[right].boundary[0]);
                node.boundary[0] = nodes[left].boundary[0];
                node.boundary[1] = nodes[right].boundary[1];
            }
            int merged = static_cast<int>(nodes.size());
            nodes.push_back(node);
            value.push_back(Cluster{});
            nodes[left].parent = merged;
            nodes[right].parent = merged;
            return merged;
        };

        auto pullNode = [&](int node) {
            int left = nodes[node].child[0];
            int right = nodes[node].child[1];
            if(nodes[node].type == MergeType::Rake) {
                value[node] = rake(value[left], value[right]);
            } else {
                assert(nodes[node].type == MergeType::Compress);
                value[node] = compress(value[left], value[right]);
            }
        };

        auto buildHeavyPath = [&](auto&& self, int head) -> pair<int, int> {
            vector<int> path;
            for(int vertex = head; vertex != -1; vertex = heavyChild[vertex]) {
                path.push_back(vertex);
            }

            vector<pair<int, int>> stack;
            stack.push_back({0, path[0]});

            auto mergeLastTwo = [&]() {
                auto [rightHeight, right] = stack.back();
                stack.pop_back();
                auto [leftHeight, left] = stack.back();
                stack.pop_back();
                int merged = mergeNode(left, right, MergeType::Compress);
                pullNode(merged);
                stack.push_back({max(leftHeight, rightHeight) + 1, merged});
            };

            for(int index = 1; index < static_cast<int>(path.size()); index++) {
                int previous = path[index - 1];
                int mainCluster = path[index];
                priority_queue<
                    pair<int, int>,
                    vector<pair<int, int>>,
                    greater<pair<int, int>>
                > queue;
                queue.push({0, mainCluster});
                for(auto [next, edgeId] : graph[previous]) {
                    (void)edgeId;
                    if(parent[next] != previous || next == heavyChild[previous]) continue;
                    queue.push(self(self, next));
                }

                while(queue.size() >= 2) {
                    auto [leftHeight, left] = queue.top();
                    queue.pop();
                    auto [rightHeight, right] = queue.top();
                    queue.pop();
                    if(right == mainCluster) {
                        swap(leftHeight, rightHeight);
                        swap(left, right);
                    }
                    int merged = mergeNode(left, right, MergeType::Rake);
                    pullNode(merged);
                    if(left == mainCluster) mainCluster = merged;
                    queue.push({max(leftHeight, rightHeight) + 1, merged});
                }

                stack.push_back(queue.top());
                while(true) {
                    int size = static_cast<int>(stack.size());
                    if(
                        size >= 3 &&
                        (stack[size - 3].first == stack[size - 2].first ||
                         stack[size - 3].first <= stack[size - 1].first)
                    ) {
                        auto last = stack.back();
                        stack.pop_back();
                        mergeLastTwo();
                        stack.push_back(last);
                    } else if(size >= 2 && stack[size - 2].first <= stack[size - 1].first) {
                        mergeLastTwo();
                    } else {
                        break;
                    }
                }
            }

            while(stack.size() >= 2) mergeLastTwo();
            return stack.back();
        };

        rootCluster = buildHeavyPath(buildHeavyPath, root).second;
        assert(static_cast<int>(nodes.size()) == 2 * n - 1);
        for(int edgeId = 0; edgeId < n - 1; edgeId++) assert(edgeLeaf[edgeId] != -1);
        edgeToLeaf = move(edgeLeaf);
    }

    void setEdge(int edgeId, i64 weight) {
        assert(0 <= edgeId && edgeId < static_cast<int>(edges.size()));
        assert(weight >= 0);
        edges[edgeId].weight = weight;
        int node = edgeToLeaf[edgeId];
        value[node] = makeEdge(weight);
        for(node = nodes[node].parent; node != -1; node = nodes[node].parent) {
            int left = nodes[node].child[0];
            int right = nodes[node].child[1];
            if(nodes[node].type == MergeType::Rake) {
                value[node] = rake(value[left], value[right]);
            } else {
                value[node] = compress(value[left], value[right]);
            }
        }
    }

    const Cluster& all() const {
        assert(rootCluster != -1);
        return value[rootCluster];
    }

    i64 diameter() const {
        return all().diameter;
    }

private:
    vector<int> edgeToLeaf;
};
