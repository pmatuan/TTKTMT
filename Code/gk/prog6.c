


#include<stdio.h>
int main(){
    int a[6] = {3, 6, -2, -5, 7, 3};
    int max = a[0] * a[1];
    int start = 0, end = 1;
    for(int i=1; i<5; i++){
        if(max < a[i] * a[i+1]){
            max = a[i] * a[i+1];
            start = i;
            end = i+1;
        }
    }
    printf("Max %d, from %d to %d\n", max, start, end);
    return 0;
}

