
%%

%set di punti di interpolazione P, 5 punti
P=[1 2 4 
    4 5 6
    1 8 9
    10 0 12
    3 1 1]; 
p=2; 
k=p+1;
p=k-1;
%U va 0 a n-k+2, e ha n+k+1 elementi
[Pc,U]=bsl.globalCurveInterp(P,p);
res=100; 
figure("Name","curva","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva bspline");
bsl.plotCloudPoint(P,6);
U
Uk=bsl.getSpan(U);
Uk