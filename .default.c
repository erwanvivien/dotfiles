#include <assert.h>
#include <err.h>
#include <errno.h>
#include <stddef.h>

#if DEBUG
#include <stdio.h>
#endif /* ! DEBUG */



#if DEBUG
int main(void)
{
    printf(" = %d\n");

    return 0;
}
#endif /* ! DEBUG */
