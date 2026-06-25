#include <template/start.cpp>

dinic1.dinic();
dinic1.mincut(S);
for(int i = 2; i < dinic1.e.size(); i += 2) {
    int u = dinic1.e[i ^ 1].v, v = dinic1.e[i].v;
    if(dinic1.e[i].c == 0)
        dinic2.add(u, v, 1);
    else
        dinic2.add(u, v, LLONG_MAX);
}
cout << dinic2.dinic() << endl;
