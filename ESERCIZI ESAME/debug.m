clc
clear all
close all 

Pc=[0 0 0
1 0 3
4 5 6
2 1 2
1 3 2
1 1 1];
p=3;
t=0.6;
%Calcolo "n"
n=size(Pc,1)-1;
res=100;
%Definisco il vettore dei nodi:
U=bsl.knotsNonPeriodic(n,p);
%Plotto le funzioni di base (miscelamento) della curva B-spline
bsl.drawN(n,p,U,res);
%Calcola gli intervalli (span) dei vettori dei nodi per curve uniformi non
%periodiche:
Uk=bsl.getSpan(U);
disp("Il numero di tratti è:")
tratti_della_curva=size(Uk,1);
%Ora vado a valutare l'indice dell'intervallo al quale appartiene il
%parametro "t" ("0-based")
i=bsl.findSpanKnot(t,n,U);
i
%Verifico che è corretta perchè lo posso verificare mostrando a video il vettore "U":
U
%Ora calcolo il vettore delle funzioni di base
N=bsl.basicFunctionBspline(i,t,p,n,U);
%I valori del vettore N rappresentano i fattori di peso di ogni punto di
%controllo della curva (influenza che ha ogni punto di controllo sulla curva).