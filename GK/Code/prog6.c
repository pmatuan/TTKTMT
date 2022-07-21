#include<stdio.h>
int main(){
    int a[8] = {2, 0, 2, 0, 5, 2, 3, 1};
    int n = 8;
    int max = a[0] * a[1];
    int start = 0, end = 1;
    for(int i=1; i<n; i++){
        if(max < a[i] * a[i+1]){
            max = a[i] * a[i+1];
            start = i;
            end = i+1;
        }
    }
    printf("Max %d, from %d to %d\n", max, start, end);
    return 0;
}

