#include <template/start.cpp>

using i128 = __int128;
istream& operator>>(istream& is, i128& n) {
    string s;
    is >> s;
    n = 0;
    bool f = 0;
    if(s[0] == '-') f = 1, s = s.substr(1);
    for(char& c : s) n = n * 10 + c - '0';
    if(f) n = -n;
    return is;
}
ostream& operator<<(ostream& os, i128 n) {
    if(n < 0) os << '-', n = -n;
    if(n > 9) os << n / 10;
    os << static_cast<char>(n % 10 + '0');
    return os;
}
