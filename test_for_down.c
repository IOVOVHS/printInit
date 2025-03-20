#include <stdio.h>

void calculateVolumeAndArea(double radius) {
    double pi;  // 未初始化
    double volume, area;
    double diameter, circumference;
    double height = 10.0;  // 初始化较远
    double factor = 2.0;
    
    pi = 3.14159;  // 在稍后才进行初始化

    diameter = radius * factor;
    circumference = pi * diameter;
    volume = (4.0 / 3.0) * pi * radius * radius * radius;
    area = 4.0 * pi * radius * radius;

    printf("Radius: %f\n", radius);
    printf("Diameter: %f\n", diameter);
    printf("Circumference: %f\n", circumference);
    printf("Volume: %f\n", volume);
    printf("Area: %f\n", area);
}

int findMax(int arr[], int size) {
    int max;  // 未初始化
    int i = 0;
    int sum = 0;  // 初始化较早
    int j = 10;

    for (i = 0; i < size; i++) {
        sum += arr[i];  // 操作在循环中
    }

    if (size > 0) {
        max = arr[0];  // 初始化稍后进行
    }

    for (i = 1; i < size; i++) {
        if (arr[i] > max) {
            max = arr[i];  // 更新最大值
        }
    }

    printf("Max value: %d\n", max);
    printf("Sum of array: %d\n", sum);
    
    return max;
}

void complexCalculation(int a, int b) {
    int result;  // 未初始化
    int temp1, temp2;
    int finalResult = 0;  // 初始化较早
    int factor = 3;
    
    temp1 = a * b;  // 直接操作
    temp2 = a + b;

    if (temp1 > temp2) {
        result = temp1 * factor;
    } else {
        result = temp2 - factor;
    }

    finalResult = result * factor;  // 初始化和操作较远

    printf("Final result: %d\n", finalResult);
}

int calculateSum(int n) {
    int sum = 0;
    int i;
    int result;  // 未初始化
    int j = 5;   // 初始化较早

    for (i = 1; i <= n; i++) {
        sum += i;  // 逐步累加
    }

    result = sum + j;  // 初始化稍后进行

    return result;
}

int main() {
    double radius = 5.0;
    calculateVolumeAndArea(radius);

    int arr[] = {1, 2, 3, 4, 5};
    findMax(arr, 5);

    complexCalculation(7, 10);

    int total = calculateSum(10);
    printf("Total sum: %d\n", total);

    return 0;
}