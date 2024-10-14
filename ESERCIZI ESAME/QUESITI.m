
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

%% QUESITO3

clc
clear all

%calcola la b-spline di grado p=3, dati i punti di controllo Pc0=[0,0,0]
%e Pc1=[-32,34,0], Pc2=[0.6,80,16], Pc3=[-65,89,31], Pc4=[-127,108,2]

Pc=[0,0,0
    -32,34,0
    0.6,80,16
    -65,89,31
    -127,108,2
    ];
%Pc matrice dei punti di controllo

%devo calcolare U perchè sta nell'argomento
%U vettore dei nodi
%per calcolare U, mi serve n (è nell'argomento)

n=size(Pc,1)-1; %il numero di punti n=(numero di righe di Pc)-1
p=3;
U=bsl.knotsNonPeriodic(n,p);
res=40; %calcolare 40 punti sulla curva (traccia)
bsl.createCurve(Pc,p,U,res);

%modificare le coordinate del punto Pc2 in [5.5 66 -0.5] e osservare quanti
%rami di curva sono influenzati dalla modifica
Pc(3,:)=[5.5 66 -0.5]; %sostituisco la 3a riga con [5.5 66 -0.5]
bsl.createCurve(Pc,p,U,res); %ricalcola tutto

%esportare la curva per modificarla in SolidWorks
tlow=0;
tup=1;
Pbs=bsl.getBsplinePoint(Pc,p,U,tlow,tup,res); %calcola i punti della B-spline
bsl.writePointonFile("Punti_quesito3.txt",Pbs); %scrive i punti in un file txt

%% QUESITO4

clc
clear all

%calcola la b-spline di grado p=4 assegnati i punti di passaggio Q0,1,2,3,4
Q=[0 0 0 %inserisco i punti di passaggio Q dati in una matrice
-32 34 0
0.6 80 16
-65 89 31
127 108 2];
p=4;

[Pc,U]=bsl.globalCurveInterp(Q,p); %interpolo i punti con la b-spline 
%la b-spline passerà quindi per questi punti
res=100;
bsl.createCurve(Pc,p,U,res);
title("b-spline");

%test plottaggio della nuvola di punti
msize=8; % msize - dimensione grafica del punto
bsl.plotCloudPoint(Q,msize); %plotta la nuvola di punti

%esportare la curva in SolidWorks
tlow=0;
tup=1;
Pbs=bsl.getBsplinePoint(Pc,p,U,tlow,tup,res); %calcola i res punti della b-spline
bsl.writePointonFile("punti_quesito4.txt",Pbs); %esporta i punti della curva

%% QUESITO5

clc
clear all

%pi è il piano di normale V passante per il punto P0
%omega_pi è la terna solidale a pi definita in modo tale che l'asse z
%locale coincida con V, mentre l'origine è il punto P0
%l'asse locale x deve essere calcolato in modo tale da coincidere col
%versore diretto dal punto P0 a P1
%la terna omega_0 è quella globale, mentre omega_pi è locale

%DATI
V=[1,1,1]; %versore normale al piano pi
P0=[0,5,-4]; %punto di origine della terna omega_pi
P1=[-0.3,6,-4.7]; %punto di origine della terna omega_0

%CALCOLO I VERSORI: assi locali 
%l'asse x locale deve essere calcolato in modo tale da coincidere con col
%versore diretto dal punto P0 a P1
vx=(P0-P1)/norm(P0-P1); %versore diretto da P0 a P1
%l'asse z locale coincide con V
vz=V/norm(V);
%l'asse y locale è ortogonale per definizione a x e z
vy=cross(vz,vx); %prodotto vettoriale tra vz e vx. vy sarà ortogonale a essi

%nella terma terna_pi definire il ramo di parabola di versore diretto da P0
%a P1. nella terna omega_pi definire il ramo di parabola di equazione
%f(x)=y=x.^2 con x appartenente all'intervallo [-2,2]. campionare la funzione
%con passo 0.5

x=-2:0.5:2; %vettore che campiona la funzione
y=x.^2;
Q=[x;y]'; %matrice dei punti campionati

%calcolare la curva b-spline di grado p=2 che interpola i punti campionati
%nella terna locale
p=2;
res=100; 
[Pc,U]=bsl.globalCurveInterp(Q,p); %interpolazione globale di Q con la b-spline
figure;
bsl.createCurve(Pc,p,U,res);
title("curva b-spline nella terna locale");

%calcolare la matrice di trasformazione 4x4 T0_pi per passare dalla terna
%locale omega_pi a quella globale omega_0
Tpi_0=[vx',vy',vz',P0'
    0,0,0,1]; %matrice per il passaggio dalla terna locale a globale
T0_pi=inv(Tpi_0); %matrice per il passaggio dalla terna globale a locale

%Pc: punti di controllo nella terna locale
%Pcg: punti di controllo nella terna globale

%calcolare la b-spline nella terna globale omega_0:
Pc(:,3)=0;
Pc(:,4)=1;
for i=1:size(Pc,1)
    Pcg(:,i)=Tpi_0*Pc(i,:)';
end
Pcg=Pcg';
n=size(Pcg,1)-1;
Ug=bsl.knotsNonPeriodic(n,p); %calcola il vettore dei nodi Ug
figure;
bsl.createCurve(Pcg,p,Ug,res);
title("curva b-spline nella terna globale");

%esportare la curva b-spline nella terna globale omega_0
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
bsl.writePointonFile("bspline_globale.txt",Pbs);

