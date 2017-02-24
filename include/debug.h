
//-------------------------------------------------------------------

void print32(bit32_keyflow bit32)
{
    int i, j;
    
    for(i=127;i>=0;i--){
        printf("\n");
        for(j=31;j>=0;j--)
            printf("%d", bit32.keyflow[i][j]);
    }
    
    printf("\n\n\n");
}

//-------------------------------------------------------------------

void print16(bit16_keyflow bit16)
{
    int i, j;
    
    for(i=127;i>=0;i--){
        printf("\n");
        for(j=15;j>=0;j--)
            printf("%d", bit16.keyflow[i][j]);
    }
    
    printf("\n\n\n");
}

//-------------------------------------------------------------------