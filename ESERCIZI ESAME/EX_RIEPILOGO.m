
%% ESERCIZI DI RIEPILOGO

clc
close all
clear all

%% ESERCIZIO2: riflessione

clc
clear all

%Calcolare la riflessione rispetto ad un piano passante per P0=[0 0] 
%e di normale V=[1 1] della curva B-Spline
%di grado 4 e definita dai seguenti punti di controllo:
%Pc=[0 0 ; -0.5 1 ; 2 1 ; 0.5 -1; 2 -1; 2.5 0.5]

%dati
N=[1,1];
P0=[0,0];

Pc=[0,0,0
    -0.5,1,0
    2,1,0
    0.5,-1,0
    2,-1,0
    2.5,0.5,0
    ]; %vettore dei punti di controllo
Pc(:,4)=1;
Pco=Pc; %vettore dei punti di controllo in coordinate omogenee
disp("vettore Pco");
disp(Pco);
disp("vettore Pc");
disp(Pc);
disp("quindi i Pc e Pco sono uguali");

%dati relativi al piano che deve essere riflesso
P0=[0,0,0]; %pi passante per p0
P0o=[0,0,0,1]; %P0o in coordinate omogenee
V=[1,1,0]; %normale al pi

%calcolo del versore di V:
versV=V/norm(V); %versore di V
disp("versore di V");
disp(versV);
versV(:,4)=1; %versore di V in coordinate omogenee
versVo=versV;
disp("versore di V omogeneo");
disp(versVo);

%calcolo vettore dei nodi U
n=size(Pc,1)-1; %numero di punti di controllo -1
p=4; %grado della curva
U=bsl.knotsNonPeriodic(n,p);

%plottaggio curva
res=100; %100 punti
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

%creo la matrice per la trasformazione di riflessione
I=eye(3,3); %matrice identità
disp("matrice identità I");
disp(I);
for i=1:size(Pc,1) %da 1 al numero di righe di Pc
    %adatto per il ciclo for la d=(P0-Pi)*N0 -> distanza di Pi da pi
    %laddove P0 è un punto del piano pi e Pi un punto riflesso sul pi, e N0
    %la normale al pi
    d=(P0o-Pc(i,:))*versVo';
    %versVo' dev'essere trasposto per diventare un vettore colonna: ciò è
    %necessario perché viene moltiplicate per una matrice
    rif=[2*d*versVo(1)
        2*d*versVo(2)
        2*d*versVo(3)
        ];
    T=I; %si pone mat trasf=mat id
    T(:,4)=rif;
    T(4,4)=1;
    Pcr(i,:)=T*Pco(i,:)'; %vettore dei punti di controllo riflessi
end

Pcr(:,4)=[]; %si elimina la coordinata omogenea
disp("Pcr");
disp(Pcr);

%plot della curva riflessa
figure;
bsl.createCurve(Pcr,p,U,res);
title("curva riflessa");


%% ESERCITAZIONE3: RIFLESSIONE

clc
clear all

%Calcolare la riflessione, rispetto a un piano passante per P0 e con 
%normale P1-P0, della B-Spline caratterizzata dai seguenti Pc:
%Pc=[0 0 0; 0 2 0; 2 2 0; 2 0 0]

Pc=[0,0,0
    0,2,0
    2,2,0
    2,0,0
    ]; %vettore dei punti di controllo
Pco=Pc;
Pco(:,4)=1; %ho converto Pc in coordinate omogenee
%Pco:vettore dei punti di controllo in coordinate omogenee
p=1; %grado della curva
n=size(Pc,1)-1; %numero di punti di controllo -1
%size(Pc,1)-1: numero di righe di Pc
U=bsl.knotsNonPeriodic(n,p); %calcolo vettore dei nodi U
res=100;
bsl.createCurve(Pc,p,U,res); %plot b-spline
title("curva b-spline");
view(3); %vediamo la curva in 3d

%dati del piano pi. piano pi definito da (P0,N0)
%N0 normale (in questo caso)=(P1-P0)
P0=[0,0,0];
P0o=[0,0,0,1];
P1=[0,2,0];
V=P1-P0;
versV=V/norm(V); %versore di V
disp("versore di V");
disp(versV);
versVo=versV;
versVo(:,4)=1; %lo trasformo in coordinate omogenee
disp("versore di V omogeneo");
disp(versVo);

%trasformazione di riflessione
%definisco la matrice identità
I=eye(3,3);

%calcolo la matrice di trasformazione col ciclo for
for i=1:size(Pc,1)
    d=(P0-Pc(i,:))*versV';
    rif=[2*d*versV(1)
        2*d*versV(2)
        2*d*versV(3)
        ];
    T=I;
    T(:,4)=rif;
    T(4,4)=1;
    Pcr(:,i)=T*Pco(i,:)';
end

%plotto la curva
figure;
bsl.createCurve(Pcr',p,U,res);
title("curva riflessa");
view(3);


%% ESERCIZIO3 - ALTERNATIVA: RIFLESSIONE