
clc
clear all

%% ESERCIZI ESAME 

%% esercizio 1 - avitabile

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
p=3; %grado curva

%calcola e plotta le funzioni di miscelamento
n=size(Pc,1)-1; %numero di Pc
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi
disp("vettore dei nodi:");
U
res=100; 
figure("Name","funzioni di miscelamento","NumberTitle","off");
N=bsl.drawN(n,p,U,res); 
title("funzioni di miscelamento");

%calcolo l'intervallo del vettore dei nodi U
Uk=bsl.getSpan(U); %span:intervallo
disp("intervalli di U:");
disp(Uk);
numS=size(Uk,1); %numero di tratti in U

%a quale tratto della curva appartiene t=0.6
t=0.6;
i=bsl.findSpanKnot(t,n,U); %indice del tratto a cui appartiene t
disp("indice del tratto a cui appartiene t");
disp(i);
disp("t appartiene all'intervallo:");
disp([U(i+1), U(i+2)]);
%se i=4, t=0.6 appartiene a [U(i+1),U(i+2)]

%vettore delle funzioni di base
F=bsl.basicFunctionBspline(i,t,p,n,U);
disp("vettore delle funzioni di base:");
disp(F); %I valori del vettore N rappresentano i fattori di peso di ogni Pc
%della curva (influenza che ha ogni punto di controllo sulla curva).

%% esercizio 2 - biancardo 

clc
clear all

%Prendere 6 punti di controllo a piacere, grado della curva p=2. Scrivere
%come è fatto il vettore dei nodi? Se ho t=0.8, mi può dire a che tratto
%appartiene? Calcoli punti della curva

Pc=[0 0.5
0.6 0.8
0.9 1.2
1.4 1.6
1.8 2
2.1 2.4]; %punti di controllo
p=2; %grado curva

%calcolo vettore dei nodi
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi
disp("vettore dei nodi U:");
disp(U);

%intervallo di U
Uk=bsl.getSpan(U);
disp("intervallo di U:");
disp(Uk);
num=size(Uk,1); %numero di tratti di U
disp("il numero di tratti è:");
disp(num);

%a che tratto appartiene t=0.8
i=bsl.findSpanKnot(0.8,n,U); %indice del tratto
%disp("indice del tratto:");
%disp(i);
disp("t=0.8 appartiene al tratt:");
disp([U(i+1),U(i+2)]);

%calcola i punti della curva
res=100;
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);

%% esercizio 3 - d'ausilio

clc
clear all

%Supponiamo di avere un vettore di tutti elementi unitari V=[1 1 1], un punto P0 di
%coordinate [1 1 1], un set di 5 punti di controllo a piacere definiti nella terna locale con
%origine P0 e asse "y" orientato lungo V, grado della curva pari a "2".
%Si calcolino i punti di controllo della Spline e il plot nella terna globale (con P0
%definito nella terna globale).

V=[1,1,1]; %asse locale
P0=[1,1,1]; %origine locale
Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2];
p=2;

%calcolo la terna locale
versV=V/norm(V);
%calcolo della base: versori unitari ortogonali a versV
B=null(versV);
B
versV %noto che devo trasporre versV

%matrice di rotazione
disp("matrice di rotazione:")
R=[B(:,1),B(:,2),versV'];
R

%matrice di trasformazione 
disp("matrice di trasformazione:")
T=[R P0'
    0 0 0 1];
T
%porto i Pc nella terna globale
%trasformo i Pco in coordinate omogenee
Pco=Pc; 
Pco(:,4)=1;
%li porto nella terna globale
Pcgo=T*Pco'; %punti di controllo nella terna globale in coordinate omogenee
Pcg=Pcgo'; %trasposta, così otteniamo tutti gli 1 all'ultima colonna
Pcg(:,4)=[]; %elimino la 4a colonna
%punti di controllo nella terna globale:
Pcg

%vettore dei nodi
res=100;
n=size(Pcg,1)-1; 
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi

%plot curva
figure("Name","bspline nella terna globale","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res); %curva nella terna globale

%% esercizio 4 

clc
clear all 

%assegna 7 punti di controllo. p=3, P1=[2,1,2] e vettore N=[0,1,1].
%calcola la curva riflessa rispetto alla retta che passa per P1 e parallela
%a N
Pc=[1 2 2
2 3 3
3 5 5
4 6 8
5 6 8
6 8 8
9 10 10]; %punti di controllo
P1=[2,1,2]; %retta passante per P1
N=[0,1,1]; %retta parallela a versN

%calcolo e plot bspline
n=size(Pc,1)-1; 
p=3; 
U=bsl.knotsNonPeriodic(n,p);
res=100; 
figure("Name","riflessione della curva","NumberTitle","off");
subplot(1,2,1);
bsl.createCurve(Pc,p,U,res);
title("curva bspline"); 

%dati omogenei
Pco=Pc;
Pco(:,4)=1; %coordinata omogenea
P1o=P1;
P1o(:,4)=1; %aggiungo la coordinata omogenea
versN=N/norm(N);
versNo=versN;
versNo(:,4)=1; %coordinata omogenea

%trasformazione di riflessione
I=eye(3,3); %imposto la matrice identità 
for i=1:length(Pc)
    d=(P1o-Pco(i,:))*versNo';
    rif=[2*d*versNo(1)
        2*d*versNo(2)
        2*d*versNo(3)
        ];
    T=I;
    T(:,4)=rif; %nella 4a colonna metto rif
    T(4,4)=1; 
    Pcro(i,:)=T*Pco(i,:)';
end
disp("matrice di trasformazione per la riflessione")
T

Pcr=Pcro; 
Pcr(:,4)=[]; %elimino la coordinata omogenea

%plot curva riflessa
subplot(1,2,2);
bsl.createCurve(Pcr,p,U,res);
title("curva riflessa"); 

%% esercizio 5 - traslazione + da terna locale a globale

clc
clear all

%Definiamo 6 punti di controllo. Supponiamo che questi punti di controllo
%siano definiti in una terna locale "2" che ha origine in P2 di coordinate
%[1 0 1]. P2 è definito in una terna locale "1" con origine in P1 con
%coordinate [0 1 1] e ha l'asse "z" rivolto lungo il vettore di elementi [1
%1 1]. Come trasformiamo i punti Pc dalla terna locale "2" alla terna
%globale "1"? Una volta fatto ciò li plottiamo nella terna globale.

Pc=[0 0 0
1 2 3
2 5 4
7 6 5
4 8 6
9 5 2];
P2=[1 0 1]; %origine terna locale 2
P1=[0 1 1]; %origine terna globale 1
V=[1 1 1];

Pco=Pc;
Pco(:,4)=1; 
%devo passare da P2 a P1. 1: terna globale
T21=eye(4,4);
T21
T21(1:3,4)=P1'-P2';
T21
%matrice di trasformazione che mi serve per portarmi nell'origine
%della terna globale 1 

%creo la seconda matrice di trasformazione per passare dalla terna locale a
%globale
%terna locale 2
versV=V/norm(V);
B=null(versV); %creo una base ortonormale
%matrice di rotazione: 
R=[B(:,1),B(:,2),versV'];
R
%matrice di trasformazione
T=[R P1' %P1 punto della terna d'arrivo
    0 0 0 1
    ];
T
%il vettore traslazione è dato dalle coordinate dell'origine della terna
%globale 1 P1
%matrice di trasformazione complessiva
Tc=T*T21;
Pcgo=Tc*Pco'; 
Pcgo
Pcg=Pcgo;
Pcg(4,:)=[]; %tolgo la coordinata omogenea
Pcg;
Pcg=Pcg'; 
Pcg %punti di controllo nella terna globale 

%plot curva
p=3;
res=100;
n=size(Pcg,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure();
bsl.createCurve(Pcg,p,U,res);

%% esercizio 6

% Definisca 5 punti di controllo a piacere. Grado della curva p=2; t=0.3
% Si calcolino le funzioni di base relative a t=0.3

clc
clear all

Pc=[1 3 2
1 2 5
0 1 2
1 2 3
5 4 2];
p=2; 
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
Uk=bsl.getSpan(U);
i=bsl.findSpanKnot(0.3,n,U); %t=0.3
N=bsl.basicFunctionBspline(i,0.3,p,n,U); %calcolo delle funzioni base relative a t=0.3
res=100;
figure("Name","funzioni di base con t=0.3","NumberTitle","off");
N=bsl.drawN(n,p,U,res); 

%% esercizio 7 - terna globale a locale 

%Definisca 7 punti di controllo e p=3. Supponiamo che questi punti siano
%definiti nella terna globale. Supponiamo che abbiamo una terna locale con
%origine nel punto P1 di coordinate [2 1 1] e l'asse z di questa è orientata lungo
%il vettore V di componenti [1 1 1]. Fare la traformazione delle coordinate dei punti di
%controllo dalla terna globale alla terna locale. Quindi bisogna plottare la curva nella terna locale

clc 
clear all

Pc=[0 0 0
1 2 3
2 3 4
5 7 3
5 6 4
4 7 8
3 4 7
]; %definiti nella terna globale 1
p=3; 
P1=[2 1 1]; %origine terna locale 2
V=[1 1 1]; %vettore nella terna locale 2

Pco=Pc;
Pco(:,4)=1;
disp("punti di controllo in coordinate omogenee");
Pco

%trasforma i Pc dalla 1 alla 2
%versori terna locale
versV=V/norm(V); 
B=null(versV); %base ortonormale
R2=[B, versV']; %matrice di rotazione 
%R2=[B(:,1), B(:,2), versV']; %matrice di rotazione 
disp("matrice di rotazione")
R2

%matrice di trasformazione 4x4 omogenea
%matrice di rotazione R=[B(:,1), B(:,2), versV]; 
T21=[R2 P1'
    0 0 0 1
    ]; %ci metto il P0 della terna locale 2
disp("matrice di trasformazione da 2 a 1");
T21
Pclo=T21*Pco';
Pclo=Pclo';
Pcl=Pclo;
Pcl(:,4)=[]; 
Pcl

%plot curva locale
res=100;
n=size(Pcl,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","terna globale a locale","NumberTitle","off");
bsl.createCurve(Pcl,p,U,res);
title("curva bspline");

%% esercizio 13 - Rodrigues

%calcola e plotta una curva B-spline di p=4 utilizzando Pc arbitrari
%Realizza una trasformazione della curva attraverso una rotazione 
%attorno a un asse definito da un vettore V e punto P0

clc
clear all

Pc=[0 0 0
-0.5 1 0
2 1 0
0.5 -1 0
2 -1 0
2.5 0.5 0]; %punti di controllo
p=4;
P0=[-2 1 0]; %punto dell'asse
V=[1 -2 1]; %vettore V che definisce l'asse
a=30; 
%arad=30*pi/180;
%versore V
versV=V/norm(V); 
%coordinate omogenee Pco
Pco=Pc; 
Pco(:,4)=1; 

%curva bspline
n=size(Pc,1)-1; 
res=100; 
U=bsl.knotsNonPeriodic(n,p);
figure();
bsl.createCurve(Pc,p,U,res);
title("curva bspline");

%trasformazione di rotazione attorno a un asse 
%matrice di rotazione: Rodrigues 
K=kron(versV,versV'); %prodotto di Kronecker
W=[0 -versV(3) versV(2)
   versV(3) 0 -versV(1)
   -versV(2) versV(1) 0
    ];
I=eye(3,3);
R=K+cos(a)*(I-K)+sin(a)*W; %Rodrigues
%R(4,:)=0;
R(4,4)=1;

%matrice di traslazione rispetto a P0
T=I;
T(4,4)=1;
T(1:3,4)=P0'; 
Tinv=inv(T);
%matrice di trasformazione finale:
Tf=T*R*Tinv; 
%verifica dimensioni
T
R
Tinv
%trasformo i punti Pco
Pcro=Tf*Pco'; 
Pcro
Pcr=Pcro; 
Pcr(4,:)=[];
Pcr
Pcr=Pcr'; 

%plot curva ruotata
figure();
bsl.createCurve(Pcr,p,U,res);
title("curva ruotata");







