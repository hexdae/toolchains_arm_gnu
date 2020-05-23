#include "library.h"

uint16_t baz(int a)
{
    return a * 2;
}

uint32_t foo()
{
    static constexpr int k = 5;
    return baz(k);
}
