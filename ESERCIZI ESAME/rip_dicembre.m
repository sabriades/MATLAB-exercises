
%% RIPASSO DI DICEMBRE

clc 
clear all

%% esercizio 1

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
p=3; %grado della curva

%funzioni di miscelamento
n=size(Pc,1)-1;
res=100; 
%vettore dei nodi U 
U=bsl.knotsNonPeriodic(n,p);
disp("vettore dei nodi:");
U
figure("Name","Fig1 - funzioni di miscelamento","NumberTitle","off");
bsl.drawN(n,p,U,res); %plotta le funzioni di miscelamento
title("funzioni di miscelamento");

%a quale tratto della curva appartiene il parametro t=0.5
%devo individuare l'intervallo del vettore dei nodi in cui si trova t=0.6
Uk=bsl.getSpan(U); 
t=0.6;
i=bsl.findSpanKnot(t,n,U); 
disp("indice i del tratto a cui appartiene t=0.6:");
i
disp("intervallo del vettore dei nodi che contiene t=0.6");
disp([U(i+1),U(i+2)]);

%Per questo valore di t si determini il valore delle funzioni di miscelamento 
% e i valori delle funzioni di base
F=bsl.basicFunctionBspline(i,t,p,n,U);
disp("vettore delle funzioni di base");
F
% F è il vettore che contiene i fattori di peso attribuiti a ogni punto
% della curva - gli h (pesi) rappresentano l'influenza che un punto ha
% sulla curva

%% esercizio 1.2

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
      3 5 6]; %punti di controllo
p=3; %grado della curva

%plotta le funzioni di base/miscelamento b-spline relative all'insieme di punti
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi
res=100; %risoluzione della curva (# di punti che la compongono)
figure("Name","Fig1 - funzioni di base","NumberTitle","off");
bsl.drawN(n,p,U,res);
title("funzioni di base");

%per t=0.5 individua il tratto di curva corrispondente e calcola i valori
%delle funzioni di miscelamento/base
Uk=bsl.getSpan(U); %intervalli del vettore dei nodi U
i=bsl.findSpanKnot(0.5,n,U); 
disp("intervallo del vettore dei nodi contenente t=0.5 è:");
disp([U(i+1),U(i+2)]);

%calcola i valori delle funzioni di miscelamento/base
N=bsl.basicFunctionBspline(i,0.5,p,n,U); %vettore delle funzioni di base

%curva b-spline
figure("Name","Fig2 - curva b-spline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

%% esercizio 2

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
p=2; %grado della curva

%vettore dei nodi U
n=size(Pc,1)-1; %numero di punti di controllo -1 
U=bsl.knotsNonPeriodic(n,p);

%a che tratto appartiene t=0.8?
Uk=bsl.getSpan(U); %intervalli del vettore dei nodi
t=0.5;
i=bsl.findSpanKnot(t,n,U); %indice dell'intervallo che contiene t
disp("l'intervallo che contiene t=0.5 è:");
disp([U(i+1),U(i+2)]);

%calcola i punti della curva
res=100;
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res); %mi darà 100 punti, xk res=100
bsl.writePointonFile("rip_dec_ex2.txt",Pbs);

%bonus: curva b-spline
figure("Name","Fig2 - curva b-spline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

%% esercizio 3

clc
clear all 

%Supponiamo di avere un vettore di tutti elementi unitari V=[1 1 1], un punto P0 di
%coordinate [1 1 1], un set di 5 punti di controllo a piacere definiti nella terna locale con
%origine P0 e asse "y" orientato lungo V, grado della curva pari a "2".
%Si calcolino i punti di controllo della Spline e il plot nella terna globale (con P0
%definito nella terna globale).

Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2]; %punti di controllo
p=2; %grado della curva
V=[1 1 1]; %vettore
P0=[1 1 1]; %punto

%asse y orientato lungo V
versV=V/norm(V); %versore di V
%calcolo della base: due versori unitari ortogonali tra loro e a versV
B=null(versV); %base 
versV
B
R=[B(:,1),B(:,2),versV']; %matrice di rotazione
R

T10=[R P0'
    0 0 0 1]; %matrice di trasformazione dalla terna 1 a 0
T10
%terna0=terna globale
%terna1=terna locale
Pco=Pc;
Pco(:,4)=1; 
Pco %Pco in coordinate omogenee
Pcog=T10*Pco';
Pcog
Pcg=Pcog';
Pcg(:,4)=[];
Pcg

%calcolo dei punti di controllo della b-spline
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
res=100; 
Pbs=bsl.getBsplinePoint(Pcg,p,U,0,1,res);
bsl.writePointonFile("rip_dec_ex3.txt",Pbs);

%plot nella terna globale
figure("Name","Fig1 - curva b-spline","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("b-spline");

%% esercizio 3.1

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
%terna1=terna locale
%terna0=terna globale
P0=[1 2 3]; %punto - origine (origine della terna1)
V=[0 0 1]; %vettore - l'asse y è orientato lungo V (asse della terna1)
%determina i punti nella terna globale (terna0)
versV=V/norm(V);
B=null(versV); %base ortonormale di versV
versV
B
R=[B(:,1),B(:,2),versV'];
R %matrice di rotazione
%matrice di trasformazione da 1 a 0
T10=[R P0'
    0 0 0 1];
T10
Pco=Pc;
Pco(:,4)=1;
Pco %punti Pc in coordinate omogenee
Pcog=T10*Pco';
Pcog
Pcg=Pcog';
Pcg(:,4)=[]; 
Pcg

%curva b-spline nella terna0
res=100; 
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig1 - curva b-spline nella terna0","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("curva b-spline");

%curva b-spline nella terna1
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig2 - curva b-spline nella terna1","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

%% esercizio 3.2

clc
clear all

%Supponiamo di avere un vettore di tutti elementi unitari V=[1 1 1], un punto P0 di
%coordinate [1 1 1], un set di 5 punti di controllo a piacere definiti nella terna locale con
%origine P0 e asse "y" orientato lungo V, grado della curva pari a "2".
%Si calcolino i punti della Spline e il plot nella terna globale (con P0
%definito nella terna globale).

V=[1 1 1]; 
P0=[1 1 1]; 
Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2]; 
p=2;






