//-------------------------------------------------------------------

void getenergytrace(double *averagepower, int len){
    
    int i;
    double energytrace;
    FILE *fp;
    
    fp = fopen(ENERGYTRACEFILE, "w+");

    energy = 0;
    
    for(i=0;i<len;i++){
        energytrace = averagepower[i] * CLOCKCYCLETIME;
        fprintf(fp, "%0.20f\n", energytrace);
        energy += energytrace;

    }
}

//-------------------------------------------------------------------

void getenergy(void){
    
    FILE *fp;
    int i, len, *points, starttrace, endtrace;
    
    double *averagepower, sumaveragepower;
    
    sumaveragepower = 0;
    
#ifdef FIXEDVSRANDOM
    starttrace = tracenumber+1;
    endtrace = (tracenumber*2)+1;
#else
    starttrace = 1;
    endtrace = tracenumber+1;
#endif

    // Get trace length
    fp = loadtrace(1);
    tracelength = gettracelength(fp);
    instructions = tracelength;
    fclose(fp);

    averagepower = malloc(tracelength*sizeof(double));
    points = malloc(tracelength*sizeof(int));
    
    for (i=0;i<tracelength;i++){
        averagepower[i] = 0;
        points[i] = i;
    }
    
    getaverage(averagepower, tracelength, starttrace, endtrace, points, 1);
    getenergytrace(averagepower, tracelength);
    
}

//-------------------------------------------------------------------
