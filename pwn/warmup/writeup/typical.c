#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void bye()
{
    exit(-1);
}

#define SIZE 10

void *ptrs[10];

int get_index() {
    int index;
    if (scanf("%d", &index) != 1)
        bye();
    if (0 <= index && index < SIZE) return index;
    bye();
    return 0;
}

void command_malloc() {
    int index = get_index();
    unsigned long long size;
    if (scanf("%llu", &size) != 1)
        bye();

    char *buf = malloc(size);
    if (buf == NULL) bye();

    if (scanf("%s", buf) != 1) bye();
    ptrs[index] = buf;
}

void command_free() {
    int index = get_index();
    free(ptrs[index]);
}

void command_show() {
    int index = get_index();
    printf("%s\n", ptrs[index]);
    puts("Done.");
}

int main(void) {
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);
    alarm(30);

    int choice = 0;
    puts("Hello. Typical note system.");

    while(1) {
        printf("> ");
        if (scanf("%d", &choice) != 1)
            bye();

        switch(choice) {
            case 0:
                command_malloc();
                break;
            case 1:
                command_free();
                break;
            case 2:
                command_show();
                break;
            default:
                bye();
        }
    }
    return 0;
}

