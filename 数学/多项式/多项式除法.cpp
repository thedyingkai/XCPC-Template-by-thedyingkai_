#pragma once

#include "多项式求逆.cpp"

namespace poly998 {
pair<Poly, Poly> divideWithRemainder(Poly dividend, Poly divisor) {
    for(i64& value : dividend) value = norm(value);
    for(i64& value : divisor) value = norm(value);
    trim(dividend);
    trim(divisor);
    assert(!divisor.empty());
    if(dividend.size() < divisor.size()) return {{}, dividend};
    int quotientSize = (int) dividend.size() - (int) divisor.size() + 1;
    Poly reversedDividend = dividend, reversedDivisor = divisor;
    reverse(reversedDividend.begin(), reversedDividend.end());
    reverse(reversedDivisor.begin(), reversedDivisor.end());
    reversedDividend.resize(quotientSize);
    reversedDivisor.resize(quotientSize);
    Poly quotient = multiply(reversedDividend, inverse(reversedDivisor, quotientSize), quotientSize);
    reverse(quotient.begin(), quotient.end());
    Poly product = multiply(quotient, divisor);
    Poly remainder(max(0, (int) divisor.size() - 1));
    for(int i = 0; i < (int) remainder.size(); i++) {
        i64 value = i < (int) dividend.size() ? dividend[i] : 0;
        remainder[i] = norm(value - (i < (int) product.size() ? product[i] : 0));
    }
    trim(quotient);
    trim(remainder);
    return {quotient, remainder};
}

Poly divide(Poly dividend, Poly divisor) {
    return divideWithRemainder(move(dividend), move(divisor)).first;
}

Poly modulo(Poly dividend, Poly divisor) {
    return divideWithRemainder(move(dividend), move(divisor)).second;
}
}
