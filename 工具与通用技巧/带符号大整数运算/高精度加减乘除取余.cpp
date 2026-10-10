#include "../../template/start.cpp"

struct Big {
    static const int base = 1000000000;
    static const int base_digits = 9;
    vector<int> a; // little‑endian 存储各“位”：a[0] 最低
    int sign;      // +1 或 -1
    Big() : sign(1) {}
    Big(long long v) { *this = v; }
    Big& operator=(long long v) {
        sign = 1;
        u64 value = (u64) v;
        if(v < 0) {
            sign = -1;
            value = 0 - value;
        }
        a.clear();
        while(value) {
            a.push_back(int(value % base));
            value /= base;
        }
        return *this;
    }
    Big(const string& s) { read(s); }
    Big& read(const string& s) {
        sign = 1;
        a.clear();
        if(s.empty()) return *this;
        int pos = 0;
        if(s[pos] == '+' || s[pos] == '-') {
            if(s[pos] == '-') sign = -1;
            pos++;
        }
        for(int i = int(s.size()) - 1; i >= pos; i -= base_digits) {
            int x = 0, l = max(pos, i - base_digits + 1);
            for(int j = l; j <= i; j++) x = x * 10 + (s[j] - '0');
            a.push_back(x);
        }
        trim();
        return *this;
    }
    string toString() const {
        if(a.empty()) return "0";
        string s = (sign < 0 ? "-" : "") + to_string(a.back());
        char buf[20];
        for(int i = int(a.size()) - 2; i >= 0; --i) {
            snprintf(buf, sizeof(buf), "%09d", a[i]);
            s += buf;
        }
        return s;
    }
    friend ostream& operator<<(ostream& os, const Big& v) { return os << v.toString(); }
    friend istream& operator>>(istream& is, Big& v) {
        string s;
        is >> s;
        v.read(s);
        return is;
    }
    void trim() {
        while(!a.empty() && a.back() == 0) a.pop_back();
        if(a.empty()) sign = 1;
    }
    bool isZero() const { return a.empty(); }
    Big abs() const {
        Big t = *this;
        t.sign = 1;
        return t;
    }
    friend int cmpAbs(const Big& A, const Big& B) {
        if(A.a.size() != B.a.size()) return A.a.size() < B.a.size() ? -1 : 1;
        for(int i = int(A.a.size()) - 1; i >= 0; --i)
            if(A.a[i] != B.a[i]) return A.a[i] < B.a[i] ? -1 : 1;
        return 0;
    }
    friend bool operator<(const Big& A, const Big& B) {
        if(A.sign != B.sign) return A.sign < B.sign;
        int c = cmpAbs(A, B);
        return A.sign > 0 ? (c < 0) : (c > 0);
    }
    friend bool operator==(const Big& A, const Big& B) { return A.sign == B.sign && A.a == B.a; }
    friend bool operator!=(const Big& A, const Big& B) { return !(A == B); }
    friend bool operator>(const Big& A, const Big& B) { return B < A; }
    friend bool operator<=(const Big& A, const Big& B) { return !(B < A); }
    friend bool operator>=(const Big& A, const Big& B) { return !(A < B); }
    Big& operator+=(const Big& v) {
        if(sign == v.sign) {
            int carry = 0;
            for(size_t i = 0; i < max(a.size(), v.a.size()) || carry; ++i) {
                if(i == a.size()) a.push_back(0);
                a[i] += carry + (i < v.a.size() ? v.a[i] : 0);
                carry = a[i] >= base;
                if(carry) a[i] -= base;
            }
        } else {
            if(cmpAbs(*this, v) >= 0) {
                int borrow = 0;
                for(size_t i = 0; i < v.a.size() || borrow; ++i) {
                    long long sub = (long long) (i < v.a.size() ? v.a[i] : 0) + borrow;
                    if(a[i] < sub) {
                        a[i] += base;
                        borrow = 1;
                    } else
                        borrow = 0;
                    a[i] = int(a[i] - sub);
                }
            } else {
                vector<int> res = v.a;
                int borrow = 0;
                for(size_t i = 0; i < a.size() || borrow; ++i) {
                    long long sub = (long long) (i < a.size() ? a[i] : 0) + borrow;
                    if(res[i] < sub) {
                        res[i] += base;
                        borrow = 1;
                    } else
                        borrow = 0;
                    res[i] = int(res[i] - sub);
                }
                a.swap(res);
                sign = v.sign;
            }
        }
        trim();
        return *this;
    }
    Big& operator-=(const Big& v) {
        Big tmp = v;
        tmp.sign = -tmp.sign;
        return *this += tmp;
    }
    friend Big operator+(Big a, const Big& b) { return a += b; }
    friend Big operator-(Big a, const Big& b) { return a -= b; }
    Big& operator*=(int m) {
        i64 multiplier = m;
        if(multiplier < 0) {
            sign = -sign;
            multiplier = -multiplier;
        }
        long long carry = 0;
        for(size_t i = 0; i < a.size() || carry; ++i) {
            if(i == a.size()) a.push_back(0);
            long long cur = carry + a[i] * multiplier;
            a[i] = int(cur % base);
            carry = cur / base;
        }
        trim();
        return *this;
    }
    friend Big operator*(Big a, int m) { return a *= m; }
    static int powerMod(int value, int exponent, int mod) {
        i64 result = 1, baseValue = value;
        while(exponent) {
            if(exponent & 1) result = result * baseValue % mod;
            baseValue = baseValue * baseValue % mod;
            exponent >>= 1;
        }
        return (int) result;
    }
    static void numberTheoreticTransform(vector<int>& value, bool inverse, int mod) {
        int n = (int) value.size();
        for(int i = 1, j = 0; i < n; i++) {
            int bit = n >> 1;
            for(; j & bit; bit >>= 1) j ^= bit;
            j ^= bit;
            if(i < j) swap(value[i], value[j]);
        }
        for(int length = 2; length <= n; length <<= 1) {
            int root = powerMod(3, (mod - 1) / length, mod);
            if(inverse) root = powerMod(root, mod - 2, mod);
            for(int start = 0; start < n; start += length) {
                i64 factor = 1;
                int half = length >> 1;
                for(int offset = 0; offset < half; offset++) {
                    int left = value[start + offset];
                    int right = (int) (factor * value[start + offset + half] % mod);
                    int add = left + right;
                    if(add >= mod) add -= mod;
                    int subtract = left - right;
                    if(subtract < 0) subtract += mod;
                    value[start + offset] = add;
                    value[start + offset + half] = subtract;
                    factor = factor * root % mod;
                }
            }
        }
        if(inverse) {
            int inverseSize = powerMod(n, mod - 2, mod);
            for(int& x : value) x = (i64) x * inverseSize % mod;
        }
    }
    static vector<int> convolutionMod(const vector<int>& left, const vector<int>& right,
                                      int size, int mod) {
        vector<int> a(size), b(size);
        ranges::copy(left, a.begin());
        ranges::copy(right, b.begin());
        numberTheoreticTransform(a, false, mod);
        numberTheoreticTransform(b, false, mod);
        for(int i = 0; i < size; i++) a[i] = (i64) a[i] * b[i] % mod;
        numberTheoreticTransform(a, true, mod);
        return a;
    }
    static vector<int> decimalChunks(const Big& value) {
        string text = value.toString();
        int first = !text.empty() && text[0] == '-';
        vector<int> result;
        result.reserve((text.size() - first + 3) / 4);
        for(int right = (int) text.size(); right > first; right -= 4) {
            int left = max(first, right - 4), chunk = 0;
            for(int i = left; i < right; i++) chunk = chunk * 10 + text[i] - '0';
            result.push_back(chunk);
        }
        return result;
    }
    Big& operator*=(const Big& v) {
        if(isZero() || v.isZero()) return *this = 0;
        int resultSign = sign * v.sign;
        if(a.size() * v.a.size() <= 4096) {
            vector<i128> product(a.size() + v.a.size());
            for(size_t i = 0; i < a.size(); ++i)
                for(size_t j = 0; j < v.a.size(); ++j) product[i + j] += (i128) a[i] * v.a[j];
            a.clear();
            a.reserve(product.size() + 2);
            i128 carry = 0;
            for(size_t i = 0; i < product.size(); ++i) {
                i128 current = product[i] + carry;
                a.push_back((int) (current % base));
                carry = current / base;
            }
            while(carry) {
                a.push_back((int) (carry % base));
                carry /= base;
            }
            sign = resultSign;
            trim();
            return *this;
        }

        constexpr int MOD1 = 998244353;
        constexpr int MOD2 = 1004535809;
        vector<int> left = decimalChunks(*this), right = decimalChunks(v);
        int required = (int) left.size() + (int) right.size() - 1;
        int transformSize = (int) bit_ceil((unsigned) required);
        assert((MOD1 - 1) % transformSize == 0 && (MOD2 - 1) % transformSize == 0);
        vector<int> first = convolutionMod(left, right, transformSize, MOD1);
        vector<int> second = convolutionMod(left, right, transformSize, MOD2);
        int inverseMod1 = powerMod(MOD1 % MOD2, MOD2 - 2, MOD2);
        vector<u64> coefficient(required);
        for(int i = 0; i < required; i++) {
            int difference = second[i] - first[i];
            if(difference < 0) difference += MOD2;
            i64 multiplier = (i64) difference * inverseMod1 % MOD2;
            coefficient[i] = first[i] + (u64) MOD1 * multiplier;
        }
        vector<int> digit;
        digit.reserve(required + 4);
        u64 carry = 0;
        for(int i = 0; i < required || carry; i++) {
            u64 current = carry + (i < required ? coefficient[i] : 0);
            digit.push_back((int) (current % 10000));
            carry = current / 10000;
        }
        while(digit.size() > 1 && digit.back() == 0) digit.pop_back();
        string text = to_string(digit.back());
        char buffer[8];
        for(int i = (int) digit.size() - 2; i >= 0; i--) {
            snprintf(buffer, sizeof(buffer), "%04d", digit[i]);
            text += buffer;
        }
        read(text);
        sign = resultSign;
        return *this;
    }
    friend Big operator*(Big a, const Big& b) { return a *= b; }
    Big& operator/=(int v) {
        if(v == 0) throw invalid_argument("Big division by zero");
        i64 divisor = v;
        if(divisor < 0) {
            sign = -sign;
            divisor = -divisor;
        }
        long long rem = 0;
        for(int i = int(a.size()) - 1; i >= 0; --i) {
            long long cur = a[i] + rem * base;
            a[i] = int(cur / divisor);
            rem = cur % divisor;
        }
        trim();
        return *this;
    }
    friend Big operator/(Big a, int v) { return a /= v; }
    Big& operator/=(const Big& v) {
        if(v.isZero()) throw invalid_argument("Big division by zero");
        return *this = divmod(*this, v).first;
    }
    Big& operator%=(const Big& v) {
        if(v.isZero()) throw invalid_argument("Big modulo by zero");
        return *this = divmod(*this, v).second;
    }
    friend Big operator/(Big a, const Big& b) { return a /= b; }
    friend Big operator%(Big a, const Big& b) { return a %= b; }
    friend pair<Big, Big> divmod(const Big& a1, const Big& b1) {
        if(b1.isZero()) throw invalid_argument("Big division by zero");
        int norm = base / (b1.a.back() + 1);
        Big A = a1.abs() * norm;
        Big B = b1.abs() * norm;
        Big q, r;
        q.a.assign(A.a.size(), 0);
        for(int i = int(A.a.size()) - 1; i >= 0; --i) {
            r.shiftRight();
            r.a[0] = A.a[i];
            r.trim();
            long long s1 = (r.a.size() > B.a.size() ? r.a[B.a.size()] : 0);
            long long s2 = (r.a.size() > B.a.size() - 1 ? r.a[B.a.size() - 1] : 0);
            long long d = (s1 * base + s2) / B.a.back();
            if(d >= base) d = base - 1;
            Big t = B * int(d);
            while(r < t) {
                --d;
                t -= B;
            }
            r -= t;
            q.a[i] = int(d);
        }
        q.sign = a1.sign * b1.sign;
        r.sign = a1.sign;
        r /= norm;
        q.trim();
        r.trim();
        return {q, r};
    }
    void shiftRight() { a.insert(a.begin(), 0); }
};
