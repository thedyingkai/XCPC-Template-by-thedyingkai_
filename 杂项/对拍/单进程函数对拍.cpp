#include "../../template/start.cpp"

namespace Stress {
bool close(long double a, long double b, long double absoluteEps = 1e-12L,
           long double relativeEps = 1e-12L) {
    assert(absoluteEps >= 0 && relativeEps >= 0);
    if(a == b) return true;
    if(!isfinite(a) || !isfinite(b)) return false;
    long double difference = fabsl(a - b);
    return difference <= absoluteEps ||
           difference <= relativeEps * max({1.0L, fabsl(a), fabsl(b)});
}

template <class T> vector<T> unorderedAnswer(vector<T> value) {
    sort(value.begin(), value.end());
    return value;
}

template <class Generate, class Brute, class Solve, class PrintCase,
          class Equal = equal_to<>>
bool run(int tests, u64 seed, Generate generate, Brute brute, Solve solve,
         PrintCase printCase, Equal equal = {}) {
    mt19937_64 rng(seed);
    for(int test = 1; test <= tests; test++) {
        auto input = generate(rng);
        auto bruteInput = input, solveInput = input;
        auto expected = brute(bruteInput);
        auto actual = solve(solveInput);
        if(!equal(expected, actual)) {
            cerr << "mismatch: seed=" << seed << ", test=" << test << '\n';
            printCase(cerr, input);
            return false;
        }
    }
    cerr << "accepted " << tests << " tests, seed=" << seed << '\n';
    return true;
}
} // namespace Stress
