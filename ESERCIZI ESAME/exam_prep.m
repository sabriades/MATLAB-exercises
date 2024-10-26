clc
clear all 
% esercizi di preparazione all'esame con tracce casuali

%% esercizio 1

clc 
clear all 

%sono dati 5 punti di controllo Pc, p=3. plotta le funzioni di base bspline
%relative all'insieme di punti. per t=0.5 individua il tratto della curva
%corrispondente e calcola i valori delle funzioni di miscelamento.
%determina e visualizza la curva bspline corrispondente
Pc = [2 3 5 
      4 6 7 
      7 2 3 
      8 9 4
      3 5 6]; 
p=3;

%in che intervallo del vettore dei nodi si trova t?
t=0.5; 
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
Uk=bsl.getSpan(U); %intervalli del vettore dei nodi
i=bsl.findSpanKnot(t,n,U); %u è la t che ci viene data dal prof, e questa
%funzione ci dice in quale tratto si trova t
disp("t appartiene all'intervallo ");
disp([U(i+1),U(i+2)]);

%vettore delle funzioni di base
N=bsl.basicFunctionBspline(i,t,p,n,U);
disp("vettore delle funzioni di base:")
N

%calcolo e plot funzioni di miscelamento;  
res=100;
figure("Name","funzioni di base","NumberTitle","off");
N=bsl.drawN(n,p,U,res);
title("funzioni di base");

%calcolo e plot bspline
figure("Name","curva bspline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("bspline");

