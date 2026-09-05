#pragma once

#include "../多项式/多项式基础.cpp"

namespace poly998 {
i64 bostanMori(Poly numerator, Poly denominator, u64 n) {
    for(i64& value : numerator) value = norm(value);
    for(i64& value : denominator) value = norm(value);
    trim(numerator);
    trim(denominator);
    assert(!denominator.empty() && denominator[0] != 0);
    while(n) {
        Poly negative = denominator;
        for(int i = 1; i < (int) negative.size(); i += 2)
            negative[i] = negative[i] ? MOD - negative[i] : 0;
        Poly productP = multiply(numerator, negative);
        Poly productQ = multiply(denominator, negative);
        Poly nextP, nextQ;
        for(int i = n & 1; i < (int) productP.size(); i += 2) nextP.push_back(productP[i]);
        for(int i = 0; i < (int) productQ.size(); i += 2) nextQ.push_back(productQ[i]);
        numerator = move(nextP);
        denominator = move(nextQ);
        n >>= 1;
    }
    return (numerator.empty() ? 0 : numerator[0]) * power(denominator[0], MOD - 2) % MOD;
}

i64 recurrenceNth(const Poly& initial, const Poly& recurrence, u64 n) {
    int order = (int) recurrence.size();
    assert(order > 0 && (int) initial.size() >= order);
    if(n < initial.size()) return norm(initial[n]);
    Poly denominator(order + 1);
    denominator[0] = 1;
    for(int i = 0; i < order; i++) denominator[i + 1] = norm(-recurrence[i]);
    Poly start(order);
    for(int i = 0; i < order; i++) start[i] = norm(initial[i]);
    Poly numerator = multiply(start, denominator, order);
    numerator.resize(order);
    return bostanMori(move(numerator), move(denominator), n);
}
}
