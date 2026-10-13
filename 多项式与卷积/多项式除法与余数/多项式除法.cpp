#pragma once

#include "../形式幂级数求逆/多项式求逆.cpp"

namespace poly998 {
pair<Poly, Poly> divmod(Poly dividend, Poly divisor) {
    for(i64& value : dividend) value = norm(value);
    for(i64& value : divisor) value = norm(value);
    trim(dividend);
    trim(divisor);
    if(dividend.size() < divisor.size()) return {{}, dividend};
    int na = dividend.size(), nb = divisor.size();
    int qn = na - nb + 1;
    Poly revA = dividend, revB = divisor;
    reverse(revA.begin(), revA.end());
    reverse(revB.begin(), revB.end());
    revA.resize(qn);
    revB.resize(qn);
    Poly quotient = multiply(revA, inverse(revB, qn), qn);
    reverse(quotient.begin(), quotient.end());
    Poly product = multiply(quotient, divisor);
    Poly remainder(nb - 1);
    for(int i = 0; i < remainder.size(); i++) {
        i64 value = i < dividend.size() ? dividend[i] : 0;
        remainder[i] = norm(value - (i < product.size() ? product[i] : 0));
    }
    trim(quotient);
    trim(remainder);
    return {quotient, remainder};
}

Poly divide(Poly dividend, Poly divisor) {
    return divmod(move(dividend), move(divisor)).first;
}

Poly modulo(Poly dividend, Poly divisor) {
    return divmod(move(dividend), move(divisor)).second;
}
}
