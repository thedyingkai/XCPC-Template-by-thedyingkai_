#pragma once

#include "多项式除法.cpp"

namespace poly998 {
struct ProductTree {
    int n;
    vector<i64> x;
    vector<Poly> product;

    explicit ProductTree(const vector<i64>& points)
        : n((int) points.size()), x(points), product(max(1, 4 * (int) points.size())) {
        for(i64& value : x) value = norm(value);
        if(n) build(1, 0, n);
    }

    void build(int u, int l, int r) {
        if(r - l == 1) {
            product[u] = {norm(-x[l]), 1};
            return;
        }
        int m = (l + r) / 2;
        build(u * 2, l, m);
        build(u * 2 + 1, m, r);
        product[u] = multiply(product[u * 2], product[u * 2 + 1]);
    }

    void evaluateDfs(int u, int l, int r, const Poly& f, vector<i64>& answer) const {
        if(r - l == 1) {
            answer[l] = f.empty() ? 0 : norm(f[0]);
            return;
        }
        int m = (l + r) / 2;
        evaluateDfs(u * 2, l, m, modulo(f, product[u * 2]), answer);
        evaluateDfs(u * 2 + 1, m, r, modulo(f, product[u * 2 + 1]), answer);
    }

    vector<i64> evaluate(const Poly& f) const {
        vector<i64> answer(n);
        if(n) evaluateDfs(1, 0, n, modulo(f, product[1]), answer);
        return answer;
    }

    Poly interpolateDfs(int u, int l, int r, const vector<i64>& weight) const {
        if(r - l == 1) return {weight[l]};
        int m = (l + r) / 2;
        Poly left = interpolateDfs(u * 2, l, m, weight);
        Poly right = interpolateDfs(u * 2 + 1, m, r, weight);
        return add(multiply(left, product[u * 2 + 1]),
                   multiply(right, product[u * 2]));
    }

    Poly interpolate(const vector<i64>& y) const {
        assert((int) y.size() == n);
        if(n == 0) return {};
        vector<i64> denominator = evaluate(derivative(product[1]));
        vector<i64> weight(n);
        for(int i = 0; i < n; i++) {
            assert(denominator[i] != 0);
            weight[i] = norm(y[i]) * power(denominator[i], MOD - 2) % MOD;
        }
        Poly answer = interpolateDfs(1, 0, n, weight);
        answer.resize(n);
        return answer;
    }
};
}
