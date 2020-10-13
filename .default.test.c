#include <criterion/criterion.h>
#include <stddef.h>

FUNCTION_TO_CHANGE PROTOTYPE

TestSuite(FUNCTION_TO_CHANGE, .timeout = 15);

Test(FUNCTION_TO_CHANGE, empty)
{

}

int main(int argc, char *argv[])
{
    struct criterion_test_set *tests = criterion_initialize();

    int result = 0;
    if (criterion_handle_args(argc, argv, true))
        result = !criterion_run_all_tests(tests);

    criterion_finalize(tests);
    return results;
}
