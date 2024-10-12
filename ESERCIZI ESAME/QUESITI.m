
%% QUESITI

clc
clear 
close all

%% QUESITO1:
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

%% QUESITO2

clc
clear all

%campiona l'arco di circonferenza con R=1 e centro [0,0] nell'intervallo
%angolare [30,300]°. usa passo angolare di 20°. i punti campionati sono Q
theta=30*pi/180:20*pi/180:300*pi/180;
%valori in gradi convertiti in rad
R=1; %raggio unitario
x=R*cos(theta);
y=R*sin(theta);
Q=[x;y]'; %matrice dei punti campionati Q
p=2;
[Pc,U]=bsl.globalCurveInterp(Q,p); %interpolo dei punti Q
res=100; %risoluzione della curva
%plottaggio: della curva b-spline interpolante; dei punti campionati Q
%subplot(2,2,1);
bsl.createCurve(Pc,p,U,res);
title("curva b-spline interpolante con punti campionati Q");
%subplot(2,2,2);
msize=4;
bsl.plotCloudPoint(Q,msize);
%title("punti campionati Q");









