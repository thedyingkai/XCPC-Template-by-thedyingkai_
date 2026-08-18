#include "../../template/start.cpp"

// start: partition-numbers
vector<i64> partitionNumbers(int n, i64 mod) {
    if(n < 0 || mod <= 0) throw invalid_argument("invalid range or modulus");
    vector<i64> partition(n + 1);
    partition[0] = 1 % mod;
    for(int sum = 1; sum <= n; sum++) {
        i128 value = 0;
        for(i64 k = 1;; k++) {
            i64 left = k * (3 * k - 1) / 2;
            if(left > sum) break;
            i64 right = k * (3 * k + 1) / 2;
            i64 sign = k & 1 ? 1 : -1;
            value += sign * (i128) partition[sum - left];
            if(right <= sum) value += sign * (i128) partition[sum - right];
        }
        value %= mod;
        if(value < 0) value += mod;
        partition[sum] = (i64) value;
    }
    return partition;
}
// end: partition-numbers

// start: common-numbers
struct CombinatorialNumbers {
    i64 mod = 1;
    vector<i64> catalan, derangement, bell, partition;
    vector<vector<i64>> stirlingFirst, stirlingSecond, eulerian;

    i64 addMod(i64 a, i64 b) const {
        return (i64) (((i128) a + b) % mod);
    }

    void init(int n, i64 modulus) {
        if(n < 0 || modulus <= 0) throw invalid_argument("invalid range or modulus");
        mod = modulus;
        catalan.assign(n + 1, 0);
        derangement.assign(n + 1, 0);
        bell.assign(n + 1, 0);
        partition = partitionNumbers(n, mod);
        stirlingFirst.assign(n + 1, vector<i64>(n + 1));
        stirlingSecond.assign(n + 1, vector<i64>(n + 1));
        eulerian.assign(n + 1, vector<i64>(n + 1));
        if(mod == 1) return;

        catalan[0] = derangement[0] = 1;
        stirlingFirst[0][0] = stirlingSecond[0][0] = 1;
        eulerian[0][0] = 1;

        for(int i = 1; i <= n; i++) {
            for(int j = 0; j < i; j++) {
                i64 term = (i128) catalan[j] * catalan[i - 1 - j] % mod;
                catalan[i] = addMod(catalan[i], term);
            }
        }

        if(n >= 1) derangement[1] = 0;
        for(int i = 2; i <= n; i++) {
            derangement[i] = (i128) (i - 1) *
                addMod(derangement[i - 1], derangement[i - 2]) % mod;
        }

        for(int i = 1; i <= n; i++) {
            for(int k = 1; k <= i; k++) {
                i64 firstTerm = (i128) (i - 1) * stirlingFirst[i - 1][k] % mod;
                i64 secondTerm = (i128) k * stirlingSecond[i - 1][k] % mod;
                stirlingFirst[i][k] = addMod(stirlingFirst[i - 1][k - 1], firstTerm);
                stirlingSecond[i][k] = addMod(stirlingSecond[i - 1][k - 1], secondTerm);
            }
            for(int k = 0; k < i; k++) {
                i64 left = k == 0 ? 0 : (i128) (i - k) * eulerian[i - 1][k - 1] % mod;
                i64 right = (i128) (k + 1) * eulerian[i - 1][k] % mod;
                eulerian[i][k] = addMod(left, right);
            }
        }

        for(int i = 0; i <= n; i++) {
            for(int k = 0; k <= i; k++) {
                bell[i] = addMod(bell[i], stirlingSecond[i][k]);
            }
        }

    }
};
// end: common-numbers
