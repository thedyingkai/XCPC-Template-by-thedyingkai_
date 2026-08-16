#include "Dinic 最大流最小割.cpp"

vector<int> mincutPartition(Dinic& dinic) {
    fill(dinic.vis.begin(), dinic.vis.end(), 0);
    dinic.mincut(dinic.S);
    return dinic.vis;
}
