
//-------------------------------------------------------------------

void print32(bit32_maskflow bit32)
{
    int i, j;
    
    for(i=127;i>=0;i--){
        printf("\n");
        for(j=31;j>=0;j--)
            printf("%d", bit32.maskflow[i][j]);
    }
    
    printf("\n\n\n");
}

//-------------------------------------------------------------------

void print16(bit16_maskflow bit16)
{
    int i, j;
    
    for(i=127;i>=0;i--){
        printf("\n");
        for(j=15;j>=0;j--)
            printf("%d", bit16.maskflow[i][j]);
    }
    
    printf("\n\n\n");
}

//-------------------------------------------------------------------