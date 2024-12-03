
%% RIPASSO DI DICEMBRE

clc 
clear all

%% esercizio 1

clc
clear all

%Prenda sei punti di controllo. Grado della curva p=3. Mi plotti le
%funzioni di miscelamento? Individuare a quale tratto della curva
%appartiene il parametro t=0.6. Per questo valore di t si determini il
%valore delle funzioni di miscelamento e i valori delle funzioni di base

Pc=[0 0 0
1 0 3
4 5 6
2 1 2
1 3 2
1 1 1]; %matrice dei punti di controllo
p=3; %grado della curva

%funzioni di miscelamento
n=size(Pc,1)-1;
res=100; 
%vettore dei nodi U 
U=bsl.knotsNonPeriodic(n,p);
disp("vettore dei nodi:");
U
figure("Name","Fig1 - funzioni di miscelamento","NumberTitle","off");
bsl.drawN(n,p,U,res); %plotta le funzioni di miscelamento
title("funzioni di miscelamento");

%a quale tratto della curva appartiene il parametro t=0.5
%devo individuare l'intervallo del vettore dei nodi in cui si trova t=0.6
Uk=bsl.getSpan(U); 
t=0.6;
i=bsl.findSpanKnot(t,n,U); 
disp("indice i del tratto a cui appartiene t=0.6:");
i
disp("intervallo del vettore dei nodi che contiene t=0.6");
disp([U(i+1),U(i+2)]);

%Per questo valore di t si determini il valore delle funzioni di miscelamento 
% e i valori delle funzioni di base
F=bsl.basicFunctionBspline(i,t,p,n,U);
disp("vettore delle funzioni di base");
F
% F è il vettore che contiene i fattori di peso attribuiti a ogni punto
% della curva - gli h (pesi) rappresentano l'influenza che il punto ha
% sulla curva




