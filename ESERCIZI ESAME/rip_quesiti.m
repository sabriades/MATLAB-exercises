
clc
clear all
close all
%% RIPETIZIONE DEI QUESITI

%% QUESITO4

clc
clear all

%calcolo curva b-spline di grado p=4 assegnati i punti di passaggio
%Q0,1,2,3,4

Q=[0,0,0
    -32,34,0
    0.6,80,16
    -65,89,31
    -127,108,2
    ]; %matrice dei punti Q
p=4; %grado curva
[Pc,U]=bsl.globalCurveInterp(Q,p); %b-spline data dall'interpolazione dei punti
%ottengo il vettore dei punti di controllo Pc e il vettore dei nodi U

%eseguo plot della curva b-spline
res=100; %risoluzione curva: numero di punti
bsl.createCurve(Pc,p,U,res);
%se voglio plottare i punti di passaggio Q sulla curva
msize=8;
bsl.plotCloudPoint(Q,msize);
title("curva b-spline passante per i punti Q");

%esporto la curva in SolidWorks: esporto i 100 punti della curva
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res); %calcolo i punti della curva
bsl.writePointonFile("rip_quesito4.txt",Pbs);

%% QUESITO5 

clc
clear all

%pi è il piano di normale V passante per P0.
%omega_pi è la terna (locale) solidale a pi, definita in modo che l'asse z
%locale coincida con V. l'origine è P0
%l'asse locale x lo calcolo coincide col versore diretto da P0 a
%P1. nella terna omega_pi definisco il ramo di parabola di versore di equaz
%f(x) con x appartentente a [-2,2]. campiono la funzione con passo 0.5

%DATI
V=[1,1,1]; %versore normale al piano pi
P0=[0,5,-4]; %origine della terna omega_pi
P1=[-0.3,6,-4.7]; %punto di origine della terna omega_0

%calcolo versori degli assi locali
vx=(P0-P1)/norm(P0-P1); %versore diretto da P0 a P1
%l'asse z locale coincide con V
vz=V/norm(V); %coincide col versore di V
%l'asse y locale è ortogonale per definizione a x e z
vy=cross(vz,vx); %prodotto vettoriale
disp("versore vx");
disp(vx);
disp("versore vz");
disp(vz);
disp("versore vy");
disp(vy);

%campionamento
x=-2:0.5:2;
y=x.^2;
Q=[x;y]'; %matrice dei punti campionati
p=2; %grado curva
[Pc,U]=bsl.globalCurveInterp(Q,p); %curva interpolante
disp("Pc locale");
disp(Pc);
res=100; %risoluzione curva
figure;
%msize=8;
%bsl.plotCloudPoint(Q,msize); %plotta i punti di passaggio
bsl.createCurve(Pc,p,U,res);
title("curva locale"); %curva nella terna locale omega_pi

%dobbiamo passare da omega_pi (locale) a omega_0 (globale): matrice di trasformazione
Tpi_0=[vx',vy',vz',P0'
    0,0,0,1]; %matrice di trasformazione da omega_pi a omega_0
%ricorda che T0_pi=inv(Tpi_0);
disp("trasformazione da locale a globale");
disp(Tpi_0);

Pc(:,3)=0; %terza colonna di zeri
Pc(:,4)=1; %quarta colonna di 1
for i=1:size(Pc,1) %size(Pc,1) è il numero di righe di Pc
    Pcg(:,i)=Tpi_0*Pc(i,:)';
end
disp("Pcg globale non trasposta");
disp(Pcg);
%il ciclo va da 1 fino al numero di righe di Pc. cosa fa il ciclo? 
%i-esima colonna di Pcg è uguale alla Tpi_0 per l'i-esima riga di Pc
Pcg=Pcg';
disp("Pcg globale trasposta");
disp(Pcg);
n=size(Pcg,1)-1;
Ug=bsl.knotsNonPeriodic(n,p);
figure;
bsl.createCurve(Pcg,p,Ug,res);
title("curva globale");

%esporto i punti della curva definita nella terna omega_0 (globale)
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
bsl.writePointonFile("rip_quesito5.txt",Pbs);


