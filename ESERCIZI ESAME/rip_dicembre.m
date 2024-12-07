
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

%terna1=locale
%terna0=globale

V=[1 1 1]; %vettore nella terna1 
P0=[1 1 1]; %origine della terna1 
Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2]; %Pc definiti nella terna1 
p=2; %grado della curva
%asse "y" orientato lungo V
versV=V/norm(V);
B=null(versV);
R=[B(:,1),B(:,2),versV'];
T10=[R P0'
    0 0 0 1];
T10
Pco=Pc;
Pco(:,4)=1; 
Pco
Pcog=T10*Pco';
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
figure("Name","Fig1 - curva b-spline nella terna 1","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

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
p=3; %grado della curva
P1=[2,1,2]; 
N=[0,1,1]; 

%calcola la curva riflessa rispetto alla retta che passa per P1 e parallela
%a N
P1o=P1;
P1o(:,4)=1; %punto in coordinate omogenee
versN=N/norm(N);
versNo=versN;
versNo(:,4)=1; %versN in coordinate omogenee
Pco=Pc;
Pco(:,4)=1; %punti di controllo in coordinate omogenee

%matrice per la trasformazione di riflessione
I=eye(3,3); %matrice identità
for i=1:length(Pc)
    d=(P1o-Pco(i,:))*versNo';
    rif=[2*d*versNo(1)
        2*d*versNo(2)
        2*d*versNo(3)];
    T=I; 
    T(:,4)=rif;
    T(4,4)=1;
    Pcro(i,:)=T*Pco(i,:)'; 
end

Pcr=Pcro;
Pcr(:,4)=[]; %tolgo la quarta colonna - la coordinata omogenea
Pcr

%plot b-spline
res=100; 
n=size(Pc,1)-1; %numero di punti di controllo -1 
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig1 - curva b-spline","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline");

%plot b-spline riflessa
figure("Name","Fig2 - curva b-spline riflessa","NumberTitle","off");
bsl.createCurve(Pcr,p,U,res);
title("curva b-spline riflessa");

%% esercizio 5 

clc
clear all

%Definiamo 6 punti di controllo. Supponiamo che questi punti di controllo
%siano definiti in una terna locale "2" che ha origine in P2 di coordinate
%[1 0 1]. P2 è definito in una terna globale "1" con origine in P1 con
%coordinate [0 1 1] e ha l'asse "z" rivolto lungo il vettore di elementi [1
%1 1]. Come trasformiamo i punti Pc dalla terna locale "2" alla terna
%globale "1"? Una volta fatto ciò li plottiamo nella terna globale.
Pc=[0 0 0
1 2 3
2 5 4
7 6 5
4 8 6
9 5 2];
%terna2=terna locale
%terna1=terna globale
P2=[1 0 1]; %origine della terna2
P1=[0 1 1]; %origine della terna1
V=[1 1 1]; %asse terna1
p=3; %grado della curva

versV=V/norm(V);
B=null(versV); %base di vettori ortonormali di versV
R=[B(:,1),B(:,2),versV'];
T21=eye(4,4);
T21(1:3,4)=P1'-P2'; %origine globale - origine locale
T=[R P1'
    0 0 0 1]; %matrice di trasformazione da terna2 a terna1
Tc=T*T21; %matrice di trasformazione complessiva
Pco=Pc;
Pco(:,4)=1; 
Pcgo=Tc*Pco';
Pcg=Pcgo';
Pcg(:,4)=[]; 
Pcg %punti nella terna globale=terna1

%plot curva b-spline nella terna1
res=100;
n=size(Pcg,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig1 - curva b-spline nella terna1","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("curva b-spline nella terna globale");

%plot curva b-spline nella terna2
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig2 - curva b-spline nella terna2","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline nella terna locale");

%% esercizio 5.1 (quesito 5)

clc
clear all

%pi è il piano di normale V passante per il punto P0
%omega_pi è la terna solidale a pi definita in modo tale che l'asse z
%locale coincida con V, mentre l'origine è il punto P0
%l'asse locale x deve essere calcolato in modo tale da coincidere col
%versore diretto dal punto P0 a P1
%la terna omega_0 è quella globale, mentre omega_pi è locale

%terna globale: terna0
%terna locale: terna1

%nella terna terna_pi definire il ramo di parabola di versore diretto da P0
%a P1. nella terna omega_pi definire il ramo di parabola di equazione
%f(x)=y=x.^2 con x appartenente all'intervallo [-2,2]. campionare la funzione
%con passo 0.5

%Calcolare la matrice di trasformazione 4x4 "T0,π" per passare dalla terna locale a quella globale

V=[1 1 1];
versV=V/norm(V); %asse z terna1 
P0=[0 5 -4]; %origine terna1
P1=[-0.3 6 -4.7];
X=P1-P0; 
versX=X/norm(X); %asse x terna1
vy=cross(versV,versX); %asse y terna1 - cross è il prodotto vettoriale

%campionamento dei punti
x=-2:0.5:2; %vettore che campiona la funzione nell'intervallo
%[-2,2] con passo 0.5
y=x.^2; %equazione della parabola - funzione
Q=[x;y]'; %matrice dei punti campionati
%Calcolare la matrice di trasformazione 4x4 "T0,π" per passare dalla terna locale a quella globale
%passo da terna1 a terna0
R=[versX',vy',versV'];
T=[R P1'
   0 0 0 1];

%curva b-spline nella terna1 - terna locale
p=2;
res=100; 
[Pc,U]=bsl.globalCurveInterp(Q,p); %interpolazione globale di Q con la b-spline
figure("Name","curva b-spline nella terna1","NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("curva b-spline nella terna locale");

%definisco i punti di controllo
Pc(:,3)=0;
Pc(:,4)=1; %coordinata omogenea
for i=1:length(Pc)
    Pcg(:,i)=T*(Pc(i,:))';
end
Pcg=Pcg';
Pcg(:,4)=[];

%curva b-spline nella terna0 - terna globale
figure("Name","curva b-spline nella terna0","NumberTitle","off");
bsl.createCurve(Pcg,p,U,res);
title("curva b-spline nella terna globale");

%% esercizio 6

clc
clear all

% Definisca 5 punti di controllo a piacere. Grado della curva p=2; t=0.3
% Si calcolino le funzioni di base relative a t=0.3

Pc=[0,0,0
    -0.5,1,0
    2,1,0
    0.5,-1,0
    2,-1,0
    2.5,0.5,0
    ]; %punti di controllo
p=2; 

n=size(Pc,1)-1; %numero di punti di controllo
U=bsl.knotsNonPeriodic(n,p); %vettore dei nodi
i=bsl.findSpanKnot(0.3,n,U); %span index - indice che mi dice in quale 
%intervallo di U si trova il valore t cercato
disp("l'intervallo corrispondente è");
disp([U(i+1),U(i+2)])
N=bsl.basicFunctionBspline(i,0.3,p,n,U); %sono le relative funzioni
res=100; 
figure("Name","funzioni di base relative a t=0.3", "NumberTitle","off");
bsl.drawN(n,p,U,res);
title("funzioni di base");

%% esempio 1 (reference guide bsl)

clc
clear all
Pc=[0 0 
    -0.5 1
    2 1 
    0.5 1
    2 -1
    2.5 0.5]; %punti di controllo

%calcolare le curve b-spline dal grado 2 fino a quello 5
%calcolare 100 punti per ogni curva
n=size(Pc,1)-1;
res=100; 
figure();
for i=2:5
    p=i;
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Curva b-spline con p="+num2str(i),"NumberTitle","off");
bsl.createCurve(Pc,p,U,res);
title("Curva di grado p="+num2str(i));
end

%% alternativa 

clc 
clear all
Pc=[0 0 
    -0.5 1
    2 1 
    0.5 1
    2 -1
    2.5 0.5]; %punti di controllo
res=100; 
p=2:5;
%ax=axes();
figure("Name","curve plottate con p=2:5","NumberTitle","off");
title("curve b-spline");
n=size(Pc,1)-1; 
for i=1:length(p)
    U=bsl.knotsNonPeriodic(n,p(i));
    bsl.createCurve(Pc,p(i),U,res);
end

%% esercizio 7 

clc
clear all

%Definisca 7 punti di controllo e p=3. Supponiamo che questi punti siano
%definiti nella terna globale. Supponiamo che abbiamo una terna locale con
%origine nel punto P1 di coordinate [2 1 1] e l'asse z di questa è orientata lungo
%il vettore V di componenti [1 1 1]. Fare la traformazione delle coordinate dei punti di
%controllo dalla terna globale alla terna locale. Quindi bisogna plottare la curva nella terna locale

%terna globale: terna0
%terna locale: terna1

Pc=[0 0 0
1 2 3
2 3 4
5 7 3
5 6 4
4 7 8
3 4 7
4 6 7];
p=3;
P1=[2 1 1]; %origine terna1
V=[1 1 1]; %asse z terna1

versV=V/norm(V); 
B=null(versV);
R=[B(:,1),B(:,2),versV'];
T10=[R P1'
    0 0 0 1];
Pco=Pc;
Pco(:,4)=1; 
Pcgo=T10*Pco';
Pcg=Pcgo';
Pcg(:,4)=[];

%plottaggio curva nella terna1
res=100; 
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
subplot(1,2,1);
bsl.createCurve(Pc,p,U,res);
%view(3);
title("b-spline nella terna locale");

%plottaggio curva nella terna1
n=size(Pcg,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
subplot(1,2,2);
bsl.createCurve(Pcg,p,U,res);
title("b-spline nella terna globale");

%% esercizio 8

clc
clear all

%Definisca 6 punti di controllo a piacere (nella terna locale quindi li chiamo Pc) e grado della curva p=3.
%Supponiamo che questi punti di controllo siano definiti nella terna locale
%che ha origine in P1 che ha coordinate [2 1 0]. L'asse x di questa terna è
%orientato lungo il vettore V di coordinate [1 1 1]. Faccia la
%trasformazione e quindi il plot della curva nella terna globale.

Pc=[0.5 1 1.2
    1 0.2 -1
    0.3 -1 0.8
    1 0 0.3
    0 1 0.5
    0.3 -0.2 1];
p=3;
V=[1 1 1];
P1=[2 1 0];

%praticamente uguale a quello di prima. lo faccio un'altra volta per
%ripassare

%% esercizio 9

clc
clear all

% Definisca 6 punti di controllo a piacere. Ipotizzo che questi punti di
% controllo siano definiti in una terna locale che ha centro nel punto
% P1=[1 1 0] e che l'asse y di questa terna sia orientato lungo il vettore
% V =[1 1 1]. Fare trasformazione della curva in coordinate globali e
% plottare. Il grado della curva è p=3;

%terna locale: terna1
%terna globale: terna0

Pc1=[0 0 0
    1 2 3
    5 7 3
    0 1 0
    6 3 4
    3 2 9];
p=3;
P1=[1 1 0]; %origine terna1
V=[1 1 1]; %asse y terna1

versV=V/norm(V); 
B=null(versV);
R=[B(:,1),versV',B(:,2)];
%e poi come prima. vado avanti quando devo ripetere

%% esercizio 10

clc
clear all

%Definisca un set di 5 punti di controllo a piacere. Esegua la specchiatura
%(riflessione)
%di questi punti rispetto al piano xy
Pc=[0 0 0
    0 2 1
    2 3 1
    2 4 5
    6 7 8];
N=[0 0 1]; %normale del piano xy (la coordinata non nulla è z)
%un piano xy è definito da z=0
P0=[0 0 0];
P0o=P0;
P0o(:,4)=1; 
Pco=Pc;
Pco(:,4)=1; 
No=N;
No(:,4)=0; %normale in coordinate omogenee
I=eye(3,3);
for i=1:length(Pco)
    d=(P0o-Pco(i,:))*No';
    rif=[2*d*No(1)
        2*d*No(2)
        2*d*No(3)];
    T=I; 
    T(:,4)=rif;
    T(4,4)=1;
    Pcro(i,:)=T*Pco(i,:)';
end
Pcr=Pcro;
Pcr(:,4)=[];

%plot della curva
res=100; 
p=3; 
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
figure("Name","curva b-spline","NumberTitle","off");
subplot(1,2,1);
bsl.createCurve(Pc,p,U,res);
view(3);
title("curva b-spline"); 

%plot della curva riflessa
U=bsl.knotsNonPeriodic(n,p);
subplot(1,2,2);
bsl.createCurve(Pcr,p,U,res);
view(3)
title("curva b-spline riflessa"); 

%plottaggio dei punti Pc
figure("Name","plottaggio punti Pc","NumberTitle","off");
plot3(Pc(:,1),Pc(:,2),Pc(:,3),"LineWidth",2);

%plottaggio dei punti Pcr
figure("Name","plottaggio punti Pcr","NumberTitle","off");
plot3(Pcr(:,1),Pcr(:,2),Pcr(:,3),"LineWidth",2);

%% esercizio 11 

clc
clear all 

%%Prenda un set di 5 punti di controllo a piacere. Poniamo t=0.7. Poniamo
%%ordine della curva pari a 3 (k=3). Quanti elementi avrà il vettore "U" e
%%quali sono questi elementi? Poi usi il comando per calcolare il vettore
%%dei nodi e fare il confronto per vedere se quello che aveva previsto si
%%verifichi effettivamente anche nel calcolo. Quanti tratti avrà la nostra
%%curva?

Pc=[1 3 5
    7 3 9
    1 7 9
    7 0 3
    7 9 4];
t=0.7;
k=3;
