clear 
clc
 
% Dati iniziali
Q=[-1 1 0;0 0 0;1 1 0;2 2 0;3 -1 0];
p=3; 
Sx=0.5;
Sy=0.5;
Sz=1;
 
% Risoluzione
res=100;
 
 
% Interpolazione set di punti con B-Spline di grado assegnato
[Pc,U]=bsl.globalCurveInterp(Q,p);
 
% Numero di punti di controllo - 1
n=size(Pc,1)-1; 
 
% Plot curva B-Spline
bsl.createCurve(Pc,p,U,res)
 
% Calcolo punti della curva B-Spline
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
 
% Esportazione punti B-Spline in file txt
bsl.writePointonFile('esercizio6curvaNonScalata.txt',Pbs)
 
% Calcolo degli intervalli dei vettori dei nodi 
Uk=bsl.getSpan(U);
% Calcolo del numero di rami della curva
numrami=length(Uk);
% In alternativa, a scopo di verifica (numrami=nrami) si ha che:
nrami=n-p+1;
 
% Calcolo della matrice di scala
S=[Sx 0 0 0;0 Sy 0 0;0 0 Sz 0;0 0 0 1];
 
% Passaggio alle coordinate omogenee
Pco=Pc;
Pco(:,4)=1;
 
% Trasformazione di scala
Pcs=S*Pco';
Pcs=Pcs';
Pcs(:,4)=[];
 
disp(Pcs);
% Traslazione in z=15 
Pcs(:,3)=15;
% In alternativa sarebbe stato possibile scrivere la
% matrice di trasformazione di pura traslazione lungo z
 
 disp(Pcs);
% Plot della curva scalata e traslata
bsl.createCurve(Pcs,p,U,res);
 
% Calcolo punti della curva B-Spline scalata e traslata
Pbss=bsl.getBsplinePoint(Pcs,p,U,0,1,res);
 
% Esportazione punti B-Spline scalata e traslata in file txt
bsl.writePointonFile('esercizio6curvaScalata.txt',Pbss)
 
% Visualizzazione 3D
view(3)

 
 
