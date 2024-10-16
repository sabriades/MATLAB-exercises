clear
clc
% Dati iniziali
p=5;
Pc=[0 0 0;-0.5 1 0;2 1 0;0.5 -1 0;2 -1 0;2.5 0.5 0]
Sx=0.5;
Sy=0.7;
Sz=0.8;
% Numero di punti di controllo - 1
n=size(Pc,1)-1;
% Risoluzione
res=100;
% Parametri del piano
P0=[3 0 0];
V=[1 0 0];
N=V/norm(V);
% Calcolo del vettore dei nodi della curva
U=bsl.knotsNonPeriodic(n,p);
% Creazione spazio grafico
subplot(1,3,1)
% Plot curva
bsl.createCurve(Pc,p,U,res)
% Assegnazione titolo curva
title('bSpline')
% Creazione della matrice di scala
S=[Sx 0 0 0;0 Sy 0 0;0 0 Sz 0;0 0 0 1];
% Passaggio alle coordinate omogenee
Pco=Pc;
Pco(:,4)=1;
% Scala rispetto all'origine
Pcscalao=S*Pco';
Pcscalao=Pcscalao';
Pcscala=Pcscalao;
Pcscala(:,4)=[];
% Plot curva scalata
subplot(1,3,2)
bsl.createCurve(Pcscala,p,U,res)
title('bSplineScalata')
% Riflessione

I=eye(3,3);
for i=1:size(Pcscala,1)
d=(P0-Pcscala(i,:))*N'
t=[2*d*N(1);2*d*N(2);2*d*N(3)]
T=I
T(:,4)=t
T(4,4)=1
Pcr(:,i)=T*Pcscalao(i,:)'
end
Pcr(4,:)=[];
% Plot della curva scalata e riflessa
subplot(1,3,3)
bsl.createCurve(Pcr',p,U,res)
title('bSplineRiflessa')
view(3)


disp("Pcr");
disp(Pcr');
disp("Pcscala")
disp(Pcscala);