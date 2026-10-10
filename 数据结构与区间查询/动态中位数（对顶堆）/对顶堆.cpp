#include "../../template/start.cpp"

namespace Set {
std::multiset<i64> less, greater;
void init() {
    less.clear(), greater.clear();
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
    if(less.empty() || val_ <= *less.rbegin())
        less.insert(val_);
    else
        greater.insert(val_);
    adjust();
}
void del(i64 val_) {
    std::multiset<i64>::iterator it = less.find(val_);
    if(it != less.end())
        less.erase(it);
    else {
        it = greater.find(val_);
        if(it != greater.end()) greater.erase(it);
    }
    adjust();
}
i64 get_middle() { return *less.rbegin(); }
} // namespace Set
