#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
void getString(char *input){
    scanf("%s", input);
}
int getLength(char *input){
    int i = 0;
    int length = 0;
    while(input[i] != 0){
        if(input[i] == 10){
            input[i] = 0;
            break;
        } //Điều này không cần thiết trong C
        ++i;
        ++length;
    }
    i = length - 1; //vị trí tại phần tử cuối cùng
    return length;
}
bool isTooLongString(char *input){
    int check = getLength(input) - 50;
    if(check == 0){
        printf("Xau qua dai!\n");
    }
}
bool isStoredInMemory(char *input, char *stringlist){
    ;
}
bool checkPalindrome(char *input){
    int length = getLength(input) - 1;
    for(int i=0; i<length; i++){
        if(input[i] != input[length-i]){
            printf("Khong la xau doi xung!\n");
            return false;
        }
    }
    printf("La xau doi xung!\n");
    return true;
}
void storeStringInMemory(char *input, char *stringlist){
    if(strlen(stringlist) < 1000){
        int start = strlen(stringlist);
        for(int i = start, j = 0; i<start+strlen(input), j<strlen(input); i++, j++){
            stringlist[i] = input[j];
        }
        for(int i=start+strlen(input); i<start+50; i++){
            stringlist[i] = 32; //space ascii characters
        }
        printf("Luu thanh cong!\n");
    }
    else printf("Day bo nho!\n");
}
int main(){
    char *input = calloc(50, sizeof(char));
    char *stringlist = calloc(1000, sizeof(char));
    getString(input);
    storeStringInMemory(input, stringlist);
    printf("%d\n", getLength(input));
    printf("%s\n", stringlist);
    printf("%ld\n", strlen(stringlist));
}