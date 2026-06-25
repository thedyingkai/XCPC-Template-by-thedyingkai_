#include <template/start.cpp>

struct Prime {
    vector<int> is_prime;
    vector<i64> primes;
    void sieve(int n) {
        is_prime.assign(n + 1, 1);
        is_prime[0] = is_prime[1] = 0;
        for(int i = 2; i <= n; i++) {
            if(is_prime[i]) primes.push_back(i);
            for(int j = 0; j < primes.size() && i * primes[j] <= n; j++) {
                is_prime[i * primes[j]] = 0;
                if(i % primes[j] == 0) break;
            }
        }
    }
};
