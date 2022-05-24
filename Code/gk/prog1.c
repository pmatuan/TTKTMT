#include<stdio.h>
#include<string.h>
int main(){
    int check = 1;
    char 
    char str[100];
    scanf("%s", str);
    for(int i=0; i<strlen(str); i++){
        if(str[i]!=str[strlen(str)-1-i]){
            check = 0;
            break;
        }
    }
    if(check == 0){
        printf("Khong doi xung\n");
    }
    else printf("Doi xung\n");
}