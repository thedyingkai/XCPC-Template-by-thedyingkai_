#include <template/start.cpp>
#include <数学\高精度\高精度加减乘除取余.cpp>
i64 qp(i64 a, i64 b, i64 p) {
    i64 res = 1;
    while(b > 0) {
        if(b & 1) res = res * a % p;
        a = a * a % p;
        b >>= 1;
    }
    return res % p;
}
void LuoTianyi() {
    i64 k, x;
    cin >> k >> x;
    int mod = 1000;
    i64 n = qp(x, x, mod);
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
