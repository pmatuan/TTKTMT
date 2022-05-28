#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
void getString(char *input){
    printf("Nhap xau dau vao: ");
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
    if(check >= 0){
        printf("Xau qua dai!\n");
        return true;
    }
    return false;
}
bool isStoredInMemory(char *input, char *stringlist){
    int count = 0;
    for(int i=0; i<1000; i+=50){
        count = 0;
        for(int j=0; j<strlen(input); j++){
            if(input[j] == stringlist[i+j]) ++count;
        }
        if(count == strlen(input)) return true;
    }
    return false;
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
    int in = 1;
    char *input = calloc(50, sizeof(char));
    char *stringlist = calloc(1000, sizeof(char));
    while(in && strlen(stringlist) < 1000){
        getString(input);
        if(isTooLongString(input)) continue;
        if(checkPalindrome(input) && !isStoredInMemory(input, stringlist)){
            storeStringInMemory(input, stringlist);
        }
        printf("Ban co muon tiep tuc khong ?: ");
        scanf("%d", &in);
    }
    printf("%s\n", stringlist);
}