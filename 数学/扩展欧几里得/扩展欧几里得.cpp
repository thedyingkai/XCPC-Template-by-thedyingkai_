#include "../../template/start.cpp"

i64 exgcd(i64 a, i64 b, i64& x, i64& y) {
    if(b == 0) {
        x = 1, y = 0;
        return a;
    }
    i64 x1, y1, d;
    d = exgcd(b, a % b, x1, y1);
    x = y1, y = x1 - a / b * y1;
    return d;
}
int main() {
    i64 a, b, c;
    cin >> a >> b >> c;
    i64 x, y;
    i64 d = exgcd(a, b, x, y);
    if(c % d != 0) {
        cout << -1 << endl;
        return 0;
    }
    x *= c / d, y *= c / d;
    i64 xmin = (x % (b / d) + b / d - 1) % (b / d) + 1, ymax = (c - a * xmin) / b;
    i64 ymin = (y % (a / d) + a / d - 1) % (a / d) + 1, xmax = (c - b * ymin) / a;
    if(ymax > 0)
        cout << (xmax - xmin) / (b / d) + 1 << ' ' << xmin << ' ' << ymin << ' ' << xmax << ' ' << ymax << endl;
    else
        cout << xmin << ' ' << ymin << endl;
}
