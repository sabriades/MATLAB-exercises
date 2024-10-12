
%%QUESITI

clc
clear 
close all

%esercitazione 1:
%data la funzione polinomiale con la sua equazione, eseguine il
%campionamento nell'intervallo [-1,1] con passo 0.3. Q è la matrice
%dei punti campionati

%campionamento in [-1,1] con passo 0.3
x=-1:0.3:1; %vettore che ha inizio -1, passo 0.3, fine 1
y=-x.^3+x.^2+6; %funzione data
Q=[x;y]'; %pone x e y come righe ed poi traspone la matrice  
%trasposizione: la matrice 2xN diventa matrice Nx2
disp("matrice dei punti campionati Q")
disp(Q);

%calcolare la curva b-spline di grado p=3, interpolante i punti Q
p=3; %grado curva
[Pc,U]=bsl.globalCurveInterp(Q,p); %interpola un set di punti con una 
%curva b-spline di grado assegnato
res=100; %risoluzione della curva

%plottaggio: curva interpolante, punti Q, funzione
subplot(2,2,1); %primo riquadro con la sua grandezza
bsl.createCurve(Pc,p,U,res); %plotta la curva b-spline
title("curva interpolante");

subplot(2,2,2);
msize=6;
bsl.plotCloudPoint(Q,msize); %plotto i punti Q
title("punti Q");

subplot(2,2,3);
plot(x,y);
title("funzione f(x)");


