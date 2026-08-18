#include "../../template/start.cpp"

struct FFT {
    using CD = complex<double>;
    static void fft(vector<CD>& a, bool invert) {
        int n = (int) a.size();
        for(int i = 1, j = 0; i < n; ++i) {
            int bit = n >> 1;
            for(; j & bit; bit >>= 1) j ^= bit;
            j ^= bit;
            if(i < j) swap(a[i], a[j]);
        }
        for(int len = 2; len <= n; len <<= 1) {
            double ang = 2 * numbers::pi / len * (invert ? -1 : 1);
            CD wlen(cos(ang), sin(ang));
            for(int i = 0; i < n; i += len) {
                CD w(1);
                for(int j = 0; j < len / 2; ++j) {
                    CD u = a[i + j];
                    CD v = a[i + j + len / 2] * w;
                    a[i + j] = u + v;
                    a[i + j + len / 2] = u - v;
                    w *= wlen;
                }
            }
        }
        if(invert) {
            for(CD& x : a) x /= n;
        }
    }
    // 输入：1-index，系数在a[1..]，返回同样1-index的结果，长度为a.size()+b.size()-1
    static vector<int> multiply(const vector<int>& a, const vector<int>& b) {
        int l1 = (int) a.size() - 1;
        int l2 = (int) b.size() - 1;
        if(l1 <= 0 || l2 <= 0) return vector<int>(1, 0);
        int n = (int) bit_ceil((unsigned) (l1 + l2));
        vector<CD> fa(n), fb(n);
        for(int i = 1; i <= l1; ++i) fa[i - 1] = CD(a[i], 0);
        for(int i = 1; i <= l2; ++i) fb[i - 1] = CD(b[i], 0);
        fft(fa, false);
        fft(fb, false);
        for(int i = 0; i < n; ++i) fa[i] *= fb[i];
        fft(fa, true);
        vector<int> res(l1 + l2, 0);
        for(int i = 0; i < l1 + l2 - 1; ++i) res[i + 1] = int(round(fa[i].real()));
        return res;
    }
};
string get(vector<int> ans, int base) {
    for(int i = 1; i < (int) ans.size(); i++) {
        if(ans[i] >= base) {
            if(i + 1 >= (int) ans.size()) ans.push_back(0);
            ans[i + 1] += ans[i] / base;
            ans[i] %= base;
        }
    }
    while(ans.size() > 1 && ans.back() == 0) { ans.pop_back(); }
    string s;
    for(int i = ans.size() - 1; i >= 1; i--) { s.push_back(char('0' + ans[i])); }
    return s.empty() ? "0" : s;
}
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    // FFT示例：输入和输出都是1-index
    vector<int> a = {0, 1, 2, 3};      // a = [1,2,3]
    vector<int> b = {0, 4, 5};         // b = [4,5]
    auto resFFT = FFT::multiply(a, b); // resFFT[1..]
    for(int i = 1; i < (int) resFFT.size(); ++i) cout << resFFT[i] << " ";
    cout << "\n";
    // 高精乘
    //    string a,b;
    //    cin>>a>>b;
    //    int l1=a.length(),l2=b.length();
    //    vector<int> A(l1+1),B(l2+1);
    //    for(int i=1;i<=l1;i++) A[i]=a[l1-i]-'0';
    //    for(int i=1;i<=l2;i++) B[i]=b[l2-i]-'0';
    //    auto ans=FFT::multiply(A,B);
    return 0;
}
