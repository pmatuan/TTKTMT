#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>
void getString(char *input){
    scanf("%s", input);
    printf("%s\n", input);
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
    
}
int main(){
    char input[51];
    char stringlist[1000];
    getString(input);
    printf("%d", getLength(input));
}