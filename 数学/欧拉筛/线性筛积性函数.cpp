#include "../../template/start.cpp"

struct Sieve {
    vector<int> primes, is_prime;
    vector<int> phi;   // 欧拉函数
    vector<int> d;     // 约数个数
    vector<i64> sigma; // 约数和
    vector<int> mu;    // 莫比乌斯函数
    vector<int> cnt;
    vector<i64> p_power, p_sum;
    void init(int n) {
        primes.clear();
        is_prime.assign(n + 1, 1);
        phi.assign(n + 1, 0);
        d.assign(n + 1, 0);
        sigma.assign(n + 1, 0);
        mu.assign(n + 1, 0);
        cnt.assign(n + 1, 0);
        p_power.assign(n + 1, 0);
        p_sum.assign(n + 1, 0);
        if(n >= 0) is_prime[0] = 0;
        if(n < 1) return;
        is_prime[1] = 0;
        phi[1] = 1;   // φ(1) = 1
        d[1] = 1;     // 1 的约数个数 = 1
        sigma[1] = 1; // 1 的约数和 = 1
        mu[1] = 1;    // μ(1) = 1
        for(int i = 2; i <= n; i++) {
            if(is_prime[i]) {
                primes.push_back(i); // 质数的初始化
                phi[i] = i - 1;      // φ(p) = p-1
                d[i] = 2;            // p 的约数个数 = 1 和 p
                sigma[i] = i + 1;    // 1 + p
                mu[i] = -1;          // μ(p) = -1
                cnt[i] = 1;
                p_power[i] = i;
                p_sum[i] = i + 1;
            }
            for(int p : primes) {
                if(1LL * i * p > n) break;
                is_prime[i * p] = 0;
                if(i % p == 0) { // p 是 i 的质因数
                    phi[i * p] = phi[i] * p;
                    cnt[i * p] = cnt[i] + 1;
                    p_power[i * p] = p_power[i] * p;
                    p_sum[i * p] = p_sum[i] + p_power[i * p];
                    d[i * p] = d[i] / (cnt[i] + 1) * (cnt[i * p] + 1);
                    sigma[i * p] = sigma[i] / p_sum[i] * p_sum[i * p];
                    mu[i * p] = 0; // 有平方因子时 μ = 0
                    break;
                } else {
                    phi[i * p] = phi[i] * (p - 1);
                    d[i * p] = d[i] * 2; // 新质因子，指数为 1
                    sigma[i * p] = sigma[i] * (p + 1);
                    mu[i * p] = -mu[i]; // 新质因子 => μ 翻转符号
                    cnt[i * p] = 1;
                    p_power[i * p] = p;
                    p_sum[i * p] = p + 1;
                }
            }
        }
    }
};
