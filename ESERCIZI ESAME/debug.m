clear
clc
% Dati iniziali
Pc=[0 0 0; 2 2 1; 2 3 2 ; 3 4 3 ; 4 5 4; 6 5 5 ; 5 7 4; 8 9 3];
p=2;
res=100;
% Numero di punti di controllo - 1
n=size(Pc,1)-1;
% Calcolo del vettore dei nodi
U=bsl.knotsNonPeriodic(n,p);
% Calcolo degli intervalli dei vettori dei nodi
Uk=bsl.getSpan(U);
% Calcolo del numero di rami del poligono di controllo
nrami=length(Uk); %equivalente di n-p+1
% Creazione interfaccia grafica
subplot(1,2,1)
% Plot delle funzioni di base della curva B-Spline
bsl.drawN(n,p,U,res);
% Creazione interfaccia grafica
subplot(1,2,2)
% Plot curva B-Spline
bsl.createCurve(Pc,p,U,res);
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
view(3)