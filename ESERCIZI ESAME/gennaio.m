%% esercizio 3

clc
clear all 
close all

%Supponiamo di avere un vettore di tutti elementi unitari V=[1 1 1], un punto P0 di
%coordinate [1 1 1], un set di 5 punti di controllo a piacere definiti nella terna locale con
%origine P0 e asse "y" orientato lungo V, grado della curva pari a "2".
%Si calcolino i punti di controllo della Spline e il plot nella terna globale (con P0
%definito nella terna globale).

%terna0=globale
%terna1=locale
%passaggio dalla terna locale a globale
Pc=[0 0 0
1 5 7
2 3 8
4 4 2
0 1 2]; %punti di controllo
p=2; %grado della curva
V=[1 1 1]; %vettore
P0=[1 1 1]; %punto - origine terna locale
Pf=[0 0 0]; %origine terna globale
d=Pf-P0; %punto finale-punto iniziale

versV=V/norm(V);
B=null(versV);
R=[B(:,1),versV',B(:,2)];
T10=[R d'
    0 0 0 1];
Pco=Pc; 
Pco(:,4)=1; 
Pcgo=T10*Pco'; 
Pcg=Pcgo';
Pcg(:,4)=[];

n=size(Pc,1)-1; %numero di punti di controllo -1: 4
p=2; %grado della curva p=k-1 -> k=p+1
U=bsl.knotsNonPeriodic(n,p);
figure("Name","curva bspline","NumberTitle","off"); 
title("curva bspline")
bsl.createCurve(Pcg,p,U,100);

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

P1o=P1; 
P1o(:,4)=1;
versN=N/norm(N); 
versNo=[versN 0]; %coordinate omogenee
Pco=Pc; 
Pco(:,4)=1; 
%trasformazione di riflessione
I=eye(3,3);
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
Pcr(:,4)=[]; 
figure("Name","Fig1 - curva bspline riflessa","NumberTitle","off"); 
title("curva bspline riflessa");
U=bsl.knotsNonPeriodic(size(Pc,1)-1,3); %n=6
bsl.createCurve(Pcr,3,U,100);


%rip - okurr
% for i=1:length(Pc)
% d=(P1o-Pco(i,:))*versNo';
% rif=[2*d*versNo(1)
% 2*d*versNo(2)
% 2*d*versNo(3)];
% I=eye(3,3);
% T=I;
% T(:,4)=rif; 
% T(4,4)=1; 
% Pcro(i,:)=T*Pco(i,:)'; 
% end 

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
P2=[1 0 1]; %origine della terna2 - locale
P1=[0 1 1]; %origine della terna1 - globale
V=[1 1 1]; %asse terna1
p=3; %grado della curva

%esercizio di traslazione rigida+trasformazione rigida (passaggio da terna locale a globale)
%la prima cosa da fare è trovare la matrice di trasformazione per traslare l'origine
%poi di deve trovare la matrice di trasformazione per il passaggio dalla
%terna locale a globale
versV=V/norm(V); 
Pco=Pc; 
Pco(:,4)=1; 
%traslazione dall'origine della terna locale P2 a globale P1
I=eye(4,4);
d=P1-P2; %punto finale-punto iniziale
T=I;
T(1:3,4)=d'; 
%trasformazione rigida: dalla terna locale a globale
B=null(versV); 
R=[B(:,1),B(:,2),versV']; 
T21=[R d'
    0 0 0 1]; 
Tc=T*T21; 
Pcgo=Tc*Pco'; 
Pcg=Pcgo';
Pcg(:,4)=[]; 

n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig1 - confronto curva bspline globale e locale","NumberTitle","off"); 
subplot(1,2,1); 
title("curva bspline globale");
bsl.createCurve(Pcg,3,U,100);
subplot(1,2,2); 
title("curva bspline locale");
bsl.createCurve(Pc,3,U,100);

%% esercizio 8

clc
clear all
close all

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
V=[1 1 1]; %asse x della terna orientato lungo V
P1=[2 1 0]; %origine della terna locale
P0=[0 0 0]; %origine terna globale
Pco=Pc;
Pco(:,4)=1;
%passaggio dalla terna locale a globale
versV=V/norm(V); 
B=null(versV); 
R=[B(:,1),B(:,2),versV'];
%d=punto finale-punto iniziale
d=P0-P1;
T10=[R d'
     0 0 0 1];
Pcgo=T10*Pco'; 
Pcg=Pcgo';
Pcg(:,4)=[];
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
figure("Name","","NumberTitle","off");
title("curva globale");
bsl.createCurve(Pcg,p,U,100);

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
%un piano xy è definito da z=0 - è un piano z
P0=[0 0 0];
P0o=[P0 1];
versN=N/norm(N); 
versNo=[versN 0]; %coordinate omogenee
Pco=Pc;
Pco(:,4)=1; 

for i=1:length(Pc) %numero di righe
    d=(P0o-Pco(i,:))*versNo';
    rif=[2*d*versNo(1)
        2*d*versNo(2)
        2*d*versNo(3)];
    I=eye(3,3);
    T=I; 
    T(:,4)=rif;
    T(4,4)=1; 
    Pcro(i,:)=T*Pco(i,:)';
end
Pcr=Pcro;
Pcr(:,4)=[];

%curva bspline
%curva bspline riflessa
%plottaggio dei punti Pc e Pcr con plot3

%% esercizio 12

clc
clear all

%Metta 5 punti di controllo a piacere. Grado della curva p=2. Come è fatto
%il vettore dei nodi? Determinare i punti della curva con una res=100 e
%plottarla però non con "createCurve" ma con "plot3".
Pc=[0 1 2
    2 5 4
    3 6 7
    7 8 5
    5 2 3];
p=2;
res=100;
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
figure();
plot3(Pbs(:,1),Pbs(:,2),Pbs(:,3),"LineWidth",2);

%% esercizio 13

clc
clear all
close all 

%Sono assegnati il vettore direzione V, pto P0, pti di controllo e grado
%curva pari a 4. plottare la curva originaria e quella ruotata attorno
%all'asse

Pc=[0 0 0
    -0.5 1 0
    2 1 0
    0.5 -1 0
    2 -1 0
    2.5 0.5 0];
p=4;
P0=[-2 1 0];
V=[1 -2 1];
res=100;
alfa=30; %angolo di rotazione
a=deg2rad(alfa);

%notiamo che l'asse di rotazione non passa per l'origine, perché mi è dato
%come punto P0. allora devo prima spostare l'origine in P0 e la matrice di
%trasformazione assume la forma Tc=T*R*Tinv
P0o=[P0 1];
T=eye(4,4); %creo la prima matrice di trasformazione. è una TRASLAZIONE
T(:,4)=P0o'; 
Tinv=inv(T);
versV=V/norm(V); 
%prodotto di kronecker 
 K=kron(versV,versV');
% tensore assiale di V
 W=[0 -versV(3) versV(2)
    versV(3) 0 -versV(1)
    -versV(2) versV(1) 0]; 
%matrice di rotazione
I=eye(3,3);
R=K+cos(a)*(I-K)+sin(a)*(W);
R(4,4)=1; 
Tc=T*R*Tinv; 

Po=ones(size(Pc,1),1); %metodo alternativo per la coordinata omogenea

Pco=[Pc Po];
Pcro=Tc*Pco';
Pcr=Pcro'; 
Pcr(:,4)=[];
%plot curve
n=size(Pc,1)-1; 
U=bsl.knotsNonPeriodic(n,p);
figure("Name","Fig1 - curve bspline","NumberTitle","off");
subplot(1,2,1);
title("curva bspline");
bsl.createCurve(Pc,p,U,res);
subplot(1,2,2);
title("curva bspline ruotata");
bsl.createCurve(Pcr,p,U,res);
%view(3);

%% esercizio 14

clc
clear all

%Inserisca 5 punti di controllo a piacere definiti nella terna globale. 
%Supponiamo grado della curva pari a 2 (p=2)e supponiamo di avere un punto Po di coordinate [1 0 1] 
%che è l'origine di un'altra terna di riferimento che ha lo stesso orientamento della terna globale (è solo traslata).
%Come si fa la scala nella terna locale lungo x di 0.5? Dopo aver fatto ciò
%deve fare un plot affiancato delle due curve nella terna globale (le due
%curve devono stare nello stesso sistema di riferimento)

%terna globale: terna0
%terna locale: terna1
%fare la scala nella terna1 lungo x di sx=0.5

Pc=[0 0 0
    1 2 3
    6 7 8
    -1 3 4
    7 8 9]; %terna0
p=2;
sx=0.5;
P1=[1 0 1]; %origine terna1 (è una terna traslata rispetto all'origine)
%CASO2: P1 non coincide con P0=[0 0 0] origine della terna globale
%matrice di trasformazione Tc=T*S*Tinv
%sposto P0 nell'origine -> d=P1-P0 è il vettore traslazione. d=P1
%TRASLAZIONE
T=eye(4,4);
T(1:3,4)=P1; 
Tinv=inv(T);
s=[sx 1 1 1];
S=diag(s);
Tc=T*S*Tinv; 
Po=ones(size(Pc,1),1);
Pco=[Pc Po];
Pcso=Tc*Pco';
Pcs=Pcso';
Pcs(:,4)=[];
U=bsl.knotsNonPeriodic(size(Pc,1)-1,p);
figure("Name","curva bspline","NumberTitle","off");
subplot(1,2,1);
title("curva bspline");
bsl.createCurve(Pc,p,U,100);
subplot(1,2,2);
title("curva bspline scalata");
bsl.createCurve(Pcs,p,U,100);


