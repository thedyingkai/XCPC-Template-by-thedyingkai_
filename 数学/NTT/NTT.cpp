#include "../../template/start.cpp"

struct NTT {
    static constexpr i64 MOD = 998244353, G = 3;
    static i64 modpow(i64 a, i64 e) {
        i64 r = 1;
        a %= MOD;
        while(e) {
            if(e & 1) r = r * a % MOD;
            a = a * a % MOD;
            e >>= 1;
        }
        return r;
    }
    static void ntt(vector<i64>& a, bool invert) {
        int n = (int) a.size();
        for(int i = 1, j = 0; i < n; i++) {
            int bit = n >> 1;
            for(; j & bit; bit >>= 1) j ^= bit;
            j ^= bit;
            if(i < j) swap(a[i], a[j]);
        }
        for(int len = 2; len <= n; len <<= 1) {
            i64 wlen = modpow(G, (MOD - 1) / len);
            if(invert) wlen = modpow(wlen, MOD - 2);
            for(int i = 0; i < n; i += len) {
                i64 w = 1;
                for(int j = 0; j < len / 2; j++) {
                    i64 u = a[i + j], v = a[i + j + len / 2] * w % MOD;
                    a[i + j] = (u + v) % MOD;
                    a[i + j + len / 2] = (u - v + MOD) % MOD;
                    w = w * wlen % MOD;
                }
            }
        }
        if(invert) {
            i64 invn = modpow(n, MOD - 2);
            for(auto& x : a) x = x * invn % MOD;
        }
    }
    // wrapper: accept 1-index vectors A[1..n], B[1..m], return 1-index
    // C[1..n+m-1]
    static vector<i64> multiply(const vector<i64>& A, const vector<i64>& B) {
        int n1 = (int) A.size() - 1, n2 = (int) B.size() - 1;
        if(n1 <= 0 || n2 <= 0) return vector<i64>(1, 0);
        int n = 1;
        while(n < n1 + n2) n <<= 1;
        vector<i64> fa(n), fb(n);
        for(int i = 1; i <= n1; i++) fa[i - 1] = (A[i] % MOD + MOD) % MOD;
        for(int i = 1; i <= n2; i++) fb[i - 1] = (B[i] % MOD + MOD) % MOD;
        ntt(fa, false);
        ntt(fb, false);
        for(int i = 0; i < n; i++) fa[i] = fa[i] * fb[i] % MOD;
        ntt(fa, true);
        vector<i64> C(n1 + n2, 0);
        for(int i = 0; i < n1 + n2 - 1; i++) C[i + 1] = fa[i];
        return C;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    // NTT示例
    vector<i64> A = {0, 1, 2, 3};
    vector<i64> B = {0, 4, 5};
    auto resNTT = NTT::multiply(A, B);
    for(int i = 1; i < (int) resNTT.size(); ++i) cout << resNTT[i] << " ";
    cout << "\n";

    return 0;
}
