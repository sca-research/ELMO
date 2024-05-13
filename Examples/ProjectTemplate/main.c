#include "main.h"

#include "dep1.h"
#include "dep2.h"

const char hellostr[] = "hello,world!\n";

static void Print(const char *str, int len)
{
    int i;
    const char *c;
    for (c = str, i = 0; i < len; c++, i++)
    {
        printbyte((unsigned char *)c);
    }
    return;
}

int main(void)
{
    int x = 0, y = 0;

    Print(hellostr, sizeof(hellostr));

    starttrigger();
    DepFunc1(x, y);
    DepFunc2(x, y);
    endtrigger();

    endprogram();
    return 0;
}
