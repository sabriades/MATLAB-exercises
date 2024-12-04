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


%% esercizio 2 

clc
clear all 

%dati 7 Pc con p=4 della curva, calcola e visualizza le funzioni base della
%bspline. identifica l'intervallo del vettore dei nodi che contiene t=0.3 e
%calcola i valori delle funzioni di base per questo parametro

Pc = [1 2 2 
      3 4 5 
      5 3 6 
      7 8 4
      9 10 8
      4 3 7 
      6 5 3]; 
p=4; 
t=0.3; %in quale intervallo del vettore dei nodi è contenuto questo valore? 
u=t;

n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi
Uk=bsl.getSpan(U); %intervallo del vettore dei nodi
Uk %tratti del vettore dei nodi (intervalli per ogni tratto)
i=bsl.findSpanKnot(u,n,U);
disp("t=0.3 è contenuto nell'intervallo:");
disp([U(i+1),U(i+2)]);
N=bsl.basicFunctionBspline(i,u,p,n,U); %funzioni di base per t=u=0.3

%plot funzioni di base
res=100;
figure("Name","funzioni di base","NumberTitle","off");
N=bsl.drawN(n,p,U,res);
title("funzioni di base per t=0.3");

%plot bspline
figure("Name","curva bspline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva bspline");


%% esercizio 3

clc
clear all 

%dati 6 Pc in uno spazio 3d, definire il vettore dei nodi della bspline con
%p=2. determina il valore del parametro t=0.7, identifica l'intervallo del
%vettore dei nodi a cui appartiene e calcola i valori delle funzioni di
%miscelamento per questo valore di t. traccia la curva risultante 

Pc=[0 1 0 
    2 3 5 
    4 6 1 
    3 4 3 
    5 2 6 
    7 3 2]; 

%vettore dei nodi
p=2; 
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p); %calcola il vettore dei nodi

%t=0.7
t=0.7;
u=t;
Uk=bsl.getSpan(U); %intervalli del vettore dei nodi
Uk %stampa Uk a video
i=bsl.findSpanKnot(u,n,U);
disp("t appartiene all'intervallo");
disp([U(i+1),U(i+2)]);

%calcolo le funzioni di miscelamento
N=bsl.basicFunctionBspline(i,u,p,n,U);
res=100; 
figure("Name","funzioni di miscelamento","NumberTitle","off");
N=bsl.drawN(n,p,U,res);
title("funzioni di miscelamento per t=0.7");

%curva bspline
figure("Name","curva bspline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("bspline");

%% esercizio 4

clc
clear all

%data una terna locale di Pc definita nell'origine P0=[1,2,3] e con asse y
%orientato lungo il vettore V=[0,0,1], determina i punti nella terna
%globale e traccia il corrispondente sistema globale. il p=3

Pc=[0 0 0
    1 2 1
    2 1 3
    3 3 4
    2 4 5];
p=3;
P0=[1 2 3]; %origine locale
V=[0 0 1]; %asse locale

%terna locale
versV=V/norm(V); 
B=null(versV); %definisco una base ortonormale 
versV
B

%matrice di rotazione
R=[B(:,1),B(:,2),versV'];
R

%matrice di trasformazione
T=[R P0'
    0 0 0 1];
T

%porto i Pc nella terna globale
Pco=Pc; 
Pco(:,4)=1; %quarta coordinata è 1 
Pco
Pcgo=T*Pco'; 
Pcgo
%elimino la coordinata omogenea
Pcg=Pcgo'; 
Pcg(:,4)=[];

%curva nella terna globale
n=size(Pcg,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
res=100; 
figure("Name","curva bspline nella terna globale","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("bspline globale");

%% esercizio 5 - esame (d'ausilio) 

clc
clear all

%Supponiamo di avere un vettore di tutti elementi unitari V=[1 1 1], un punto P0 di
%coordinate [1 1 1], un set di 5 punti di controllo a piacere definiti nella terna locale con
%origine P0 e asse "y" orientato lungo V, grado della curva pari a "2".
%Si calcolino i punti della Spline e il plot nella terna globale (con P0
%definito nella terna globale).

V=[1 1 1]; %asse locale
P0=[1 1 1]; %origine locale
Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2]; %Pc definiti nella terna locale
p=2;
Pc

%
versV=V/norm(V); 
versV
B=null(versV); %base ortonormale
B
%matrice di rotazione R=[u,v,w]
R=[B(:,1),B(:,2),versV'];
R
%d=P0
T21=[R P0'
    0 0 0 1]; %trasformazione dalla terna 2 alla 1
T21

Pco=Pc;
Pco(:,4)=1; 
Pcgo=T21*Pco'; 

Pcg=Pcgo';
Pcg(:,4)=[]; 
Pcg %punti nella terna globale

%bspline nella terna globale
res=100; 
n=size(Pcg,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","curva bspline nella terna globale","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("bspline globale");

%% esercizio 6 - esame 5

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
9 5 2]; %punti locali 2
P2=[1 0 1]; %origine locale 2
P1=[0 1 1]; %origine globale 1
V=[1 1 1]; %asse globale 1

%definisco la terna
versV=V/norm(V);
B=null(versV); %base ortonormale
R=[B(:,1),B(:,2),versV']; %matrice di rotazione
T21=[R P1'
    0 0 0 1];
T21

%traslazione da P2 a P1
Tr=eye(4,4); %matrice identità 
Tr(1:3,4)=P1'-P2'; 
Tr

%trasformazione complessiva
Tc=Tr*T21; 

%punti globali
Pco=Pc;
Pco(:,4)=1; %Pc in coordinate omogenee
Pcgo=Tc*Pco'; 
Pcgo=Pcgo';
Pcg=Pcgo;
Pcg(:,4)=[];
Pcg %punti di controllo globali 1 

%plot curva globale 1
res=100; 
n=size(Pcg,1)-1;
p=3;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","curva bspline nella terna globale","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("bspline globale");


