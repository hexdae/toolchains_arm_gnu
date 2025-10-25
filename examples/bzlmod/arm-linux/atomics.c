#include <stdio.h>

// This should pick up the C-variant, not C++ one,
#include <stdatomic.h>

/**
 * Minimal C11 stdatomic.h example without threads.
 *
 * This example is designed to test the compiler's support for the
 * C11 _Atomic type specifier and the functions provided by <stdatomic.h>.
 */
int main(void) {
    atomic_int counter = ATOMIC_VAR_INIT(0);
    atomic_fetch_add(&counter, 1);
    int final_value = atomic_load(&counter);

    printf("Atomic counter initialized to 0, incremented once.\n");
    printf("Final value (read atomically): %d\n", final_value);

    return 0;
}