#include "library.h"
#include <vector>
#include <cmath>

uint16_t baz(uint8_t a) { return a * 2; }

uint32_t foo() {
    static constexpr int k = 5;
    return baz(k);
}

uint16_t foobaz() {
    std::vector<uint8_t> vec(10);
    vec.push_back(1);
    return vec[0];
}

double math_fn(double val) {
    return sin(val);
}
