#include <template/start.cpp>

namespace Set {
const i64 kInf = 1e9 + 2077;
std::multiset<i64> less, greater;
void init() {
    less.clear(), greater.clear();
    less.insert(-kInf), greater.insert(kInf);
}
void adjust() {
    while(less.size() > greater.size() + 1) {
        std::multiset<i64>::iterator it = (--less.end());
        greater.insert(*it);
        less.erase(it);
    }
    while(greater.size() > less.size()) {
        std::multiset<i64>::iterator it = greater.begin();
        less.insert(*it);
        greater.erase(it);
    }
}
void add(i64 val_) {
    if(val_ <= *greater.begin())
        less.insert(val_);
    else
        greater.insert(val_);
    adjust();
}
void del(i64 val_) {
    std::multiset<i64>::iterator it = less.lower_bound(val_);
    if(it != less.end())
        less.erase(it);
    else {
        it = greater.lower_bound(val_);
        greater.erase(it);
    }
    adjust();
}
int get_middle() { return *less.rbegin(); }
} // namespace Set
