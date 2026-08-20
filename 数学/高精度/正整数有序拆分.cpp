#include "../../template/start.cpp"
#include "高精度加减乘除取余.cpp"
i64 qp(i64 a, i64 b, i64 p) {
    i64 res = 1 % p;
    a %= p;
    if(a < 0) a += p;
    while(b > 0) {
        if(b & 1) res = (i128) res * a % p;
        a = (i128) a * a % p;
        b >>= 1;
    }
    return res;
}
void LuoTianyi() {
    i64 k, x;
    cin >> k >> x;
    int mod = 1000;
    i64 n = qp(x, x, mod);
    if(n == 0 || k <= 0 || k > n) {
        cout << 0 << endl;
        return;
    }
    vector<vector<Big>> C(n, vector<Big>(k, Big(0)));
    /*
     * g(x)=a1+a2+a3+...+ak
     * g(x)=x^x mod 1000
     * 求解的组数
     */
    auto getC = [&](i64 n, i64 k) {
        for(int i = 0; i < n; i++)
            for(int j = 0; j <= i && j < k; j++)
                if(j == 0)
                    C[i][j] = Big(1);
                else
                    C[i][j] = C[i - 1][j] + C[i - 1][j - 1];
    };
    getC(n, k);
    cout << C[n - 1][k - 1] << endl;
}
