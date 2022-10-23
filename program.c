#include <stdio.h>
#include <stdbool.h>

void inputArr(int *p_int) {
    for (int i = 0; i < 5; ++i) {
        scanf("%d", &p_int[i]);
    }
}

void createNewArr(const int *a, int *b) {
    bool isFirstPositive = true;
    for (int i = 4; i >= 0; --i) {
        if (isFirstPositive && a[i] > 0) {
            isFirstPositive = false;
        } else if (!isFirstPositive) {
            b[3 - i] = a[i];
        } else {
            b[4 - i] = a[i];

        }
    }
}

bool havePositive(const int *p_int) {
    for (int i = 0; i < 5; ++i) {
        if (p_int[i] > 0) {
            return true;
        }
    }
    return false;
}

void printArr(const int *p_int, int size) {
    for (int i = 0; i < size; ++i) {
        printf("%d ", p_int[i]);
    }
}

int main() {
    int a[5];
    inputArr(a);
    if (havePositive(a)) {
        int b[4];
        createNewArr(a, b);
        printArr(b,4);
    } else {
        int b[5];
        createNewArr(a, b);
        printArr(b, 5);
    }
}
