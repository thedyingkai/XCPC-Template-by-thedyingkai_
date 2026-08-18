#include "../../template/start.cpp"

// start: nim
bool firstWinsNim(const vector<u64>& heaps) {
    u64 value = 0;
    for(u64 x : heaps) value ^= x;
    return value != 0;
}

bool firstWinsMisereNim(const vector<u64>& heaps) {
    u64 value = 0;
    int nonzero = 0;
    bool hasLarge = false;
    for(u64 x : heaps) {
        value ^= x;
        nonzero += x != 0;
        hasLarge |= x > 1;
    }
    if(!hasLarge) return nonzero % 2 == 0;
    return value != 0;
}
// end: nim

// start: subtraction-game
vector<int> subtractionGameSG(int maxState, vector<int> moves) {
    erase_if(moves, [](int x) { return x <= 0; });
    sort(moves.begin(), moves.end());
    moves.erase(unique(moves.begin(), moves.end()), moves.end());
    vector<int> sg(maxState + 1), seen(moves.size() + 2, -1);
    for(int state = 1; state <= maxState; state++) {
        for(int take : moves) {
            if(take > state) break;
            int value = sg[state - take];
            if(value < (int) seen.size()) seen[value] = state;
        }
        while(sg[state] < (int) seen.size() && seen[sg[state]] == state) sg[state]++;
    }
    return sg;
}
// end: subtraction-game

// start: dag-sg
struct DAGSpragueGrundy {
    vector<vector<int>> graph;
    vector<int> sg, state;

    explicit DAGSpragueGrundy(vector<vector<int>> g)
        : graph(move(g)), sg(graph.size()), state(graph.size()) {}

    int get(int u) {
        if(state[u] == 2) return sg[u];
        if(state[u] == 1) throw logic_error("SG requires an acyclic game graph");
        state[u] = 1;
        vector<int> values;
        values.reserve(graph[u].size());
        for(int v : graph[u]) values.push_back(get(v));
        sort(values.begin(), values.end());
        values.erase(unique(values.begin(), values.end()), values.end());
        for(int x : values) {
            if(x == sg[u]) sg[u]++;
            else if(x > sg[u]) break;
        }
        state[u] = 2;
        return sg[u];
    }
};
// end: dag-sg
