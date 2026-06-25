#include <template/start.cpp>

struct Big {
    static const int base = 1000000000;
    static const int base_digits = 9;
    vector<int> a; // little‑endian 存储各“位”：a[0] 最低
    int sign;      // +1 或 -1
    Big() : sign(1) {}
    Big(long long v) { *this = v; }
    Big& operator=(long long v) {
        sign = 1;
        if(v < 0) {
            sign = -1;
            v = -v;
        }
        a.clear();
        while(v) {
            a.push_back(int(v % base));
            v /= base;
        }
        return *this;
    }
    Big(const string& s) { read(s); }
    Big& read(const string& s) {
        sign = 1;
        a.clear();
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
        if(m < 0) {
            sign = -sign;
            m = -m;
        }
        long long carry = 0;
        for(size_t i = 0; i < a.size() || carry; ++i) {
            if(i == a.size()) a.push_back(0);
            long long cur = carry + 1LL * a[i] * m;
            a[i] = int(cur % base);
            carry = cur / base;
        }
        trim();
        return *this;
    }
    friend Big operator*(Big a, int m) { return a *= m; }
    Big& operator*=(const Big& v) {
        vector<__int128> prod(a.size() + v.a.size());
        for(size_t i = 0; i < a.size(); ++i)
            for(size_t j = 0; j < v.a.size(); ++j) prod[i + j] += (__int128) a[i] * v.a[j];
        sign *= v.sign;
        a.assign(prod.size(), 0);
        __int128 carry = 0;
        for(size_t i = 0; i < prod.size(); ++i) {
            __int128 cur = prod[i] + carry;
            a[i] = int(cur % base);
            carry = cur / base;
        }
        trim();
        return *this;
    }
    friend Big operator*(Big a, const Big& b) { return a *= b; }
    Big& operator/=(int v) {
        if(v < 0) {
            sign = -sign;
            v = -v;
        }
        long long rem = 0;
        for(int i = int(a.size()) - 1; i >= 0; --i) {
            long long cur = a[i] + rem * base;
            a[i] = int(cur / v);
            rem = cur % v;
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
