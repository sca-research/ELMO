unsigned int tracenumber, instructions, leakyinstructionno = 0;

FILE * loadtrace(int t){
    
    FILE *fp;
    char str[500], filepath[500];
    
    strcpy(str, TRACEFOLDER);
    strcat(str, TRACEFILE);
    sprintf(filepath, str, t);
    fp = fopen(filepath, "r");
    
    if(fp == NULL){
        
        printf("Error\n");
        
    }
    
    return fp;
    
}

//-------------------------------------------------------------------

int gettracelength(FILE *fp){
    
    int lines = 0;
    char ch;
    while(!feof(fp))
    {
        
        ch = fgetc(fp);
        if(ch == '\n')
        {
            lines++;
        }
    }
    
    return lines;
}

//-------------------------------------------------------------------

void gettrace(double *ptr, FILE *fp, int len){
    int i;
    double value;
    for(i=0;i<len;i++)
    {
        fscanf(fp,"%lf",&value);
        ptr[i] = value;
    }
}

//-------------------------------------------------------------------

void getaverage(double *average, int len, int start, int end){
    
    int i, j;
    FILE *fp;
    double *temp;
    temp = malloc(len*sizeof(double));
    
    for(i=start;i<end;i++){
        
        fp = loadtrace(i);
        gettrace(temp, fp, len);
        fclose(fp);
        
        for(j=0;j<len;j++){
            average[j] += temp[j];
        }
    }
    
    for(j=0;j<len;j++){
        average[j] /= tracenumber;
    }
}

//-------------------------------------------------------------------

void getvariance(double *variance, int len, double *average, int start, int end){
    
    int i, j;
    FILE *fp;
    double *temp;
    temp = malloc(len*sizeof(double));
    
    for(i=start;i<end;i++){
        
        fp = loadtrace(i);
        gettrace(temp, fp, len);
        fclose(fp);
        
        for(j=0;j<len;j++){
            variance[j] += pow((temp[j] - average[j]),2);
        }
    }
    
    for(j=0;j<len;j++){
        variance[j] /= (tracenumber-1);
    }
}

//-------------------------------------------------------------------

void getttest(double *ttest, double *randomaverage, double *randomvariance, double *fixedaverage, double *fixedvariance, int len){
    
    int i;
   // FILE *fp;
    
    //fp = fopen(FIXEDVSRANDOMTTEST, "w");
    
    for(i=0;i<len;i++){

        ttest[i] = ((fixedaverage[i] - randomaverage[i]) / (sqrt((fixedvariance[i]/tracenumber)+(randomvariance[i]/tracenumber))));

   //     fprintf(fp, "%0.20f\n", ttest[i]);
    }

  //  fclose(fp);

}

//-------------------------------------------------------------------

void fixedvsrandom(void){
    
    FILE *fp;
    int i, len;
    double *fixedaverage, *randomaverage, *fixedvariance, *randomvariance, *ttest;
    
    // Get trace length
    fp = loadtrace(1);
    len = gettracelength(fp);
    instructions = len;
    fclose(fp);
    
    // Create variables
    fixedaverage = malloc(len*sizeof(double));
    randomaverage = malloc(len*sizeof(double));
    fixedvariance = malloc(len*sizeof(double));
    randomvariance = malloc(len*sizeof(double));
    ttest = malloc(len*sizeof(double));
    
    for (i=0;i<len;i++){
        fixedaverage[i] = 0;
        randomaverage[i] = 0;
        fixedvariance[i] = 0;
        randomvariance[i] = 0;
        ttest[i] = 0;
    }

    // Get random average and variance. Fixed average is same as trace and variance is 0.
    getaverage(fixedaverage, len, 1, tracenumber+1);
#ifdef DBUG
    printf("FIXED AVERAGE... OK\n");
#endif
    getaverage(randomaverage, len, tracenumber+1, (tracenumber*2)+1);
#ifdef DBUG
    printf("RANDOM AVERAGE... OK\n");
#endif
    getvariance(fixedvariance, len, fixedaverage, 1, tracenumber+1);
#ifdef DBUG
    printf("FIXED VARIANCE... OK\n");
#endif
    getvariance(randomvariance, len, randomaverage, tracenumber+1, (tracenumber*2)+1);
#ifdef DBUG
    printf("RANDOM VARIANCE... OK\n");
#endif
    getttest(ttest, randomaverage, randomvariance, fixedaverage, fixedvariance, len);
#ifdef DBUG
    printf("TTEST... OK\n");
#endif
    fp = fopen(FIXEDVSRANDOMFILE, "w+");

    // Index from 1

    for(i=0;i<len;i++){
        fprintf(fp, "%f\n", ttest[i]);
        if(ttest[i] < -FIXEDVSRANDOMFAIL | ttest[i] > FIXEDVSRANDOMFAIL){
            leakyinstructionno++;
        }
    }
}

//-------------------------------------------------------------------
