#include "../../template/start.cpp"

using i128 = __int128;
istream& operator>>(istream& is, i128& n) {
    string s;
    is >> s;
    n = 0;
    bool negative = !s.empty() && s[0] == '-';
    for(size_t i = negative || (!s.empty() && s[0] == '+'); i < s.size(); i++)
        n = n * 10 + (negative ? -(s[i] - '0') : s[i] - '0');
    return is;
}
ostream& operator<<(ostream& os, i128 n) {
    using u128 = __uint128_t;
    u128 value = n;
    if(n < 0) os << '-', value = -value;
    char digits[40];
    int len = 0;
    do {
        digits[len++] = char('0' + value % 10);
        value /= 10;
    } while(value);
    while(len) os << digits[--len];
    return os;
}
