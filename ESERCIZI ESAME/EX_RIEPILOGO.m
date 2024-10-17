
%% ESERCIZI DI RIEPILOGO

clc
close all
clear all


%% ESERCIZIO1 (QUESITO5) - DA TERNA LOCALE A BLOBALE 

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


%% ESERCITAZIONE 3 - RIFLESSIONE (alternativa)

clc
clear all

%calcolare la riflessione rispetto a P0 con normale P1-P0 della b-spline
%caratterizzata dai seguenti Pc

Pc=[0,0
    0,2
    2,2
    2,0
    ];
Pc(:,3)=0; %3a colonna di Pc ha valore nullo
disp("Pc:");
disp(Pc);
Pco=Pc; %definisco Pco
Pco(:,4)=1; %aggiungo la quarta colonna di 1 a Pco
%Pco in coordinate omogenee
disp("Pco:");
disp(Pco);

%caratterizzazione del piano (P0, P1-P0)
P1=[2,2,0]; %ho aggiunto a P0 e P1 la terza coordinata nulla
P0=[0,0,0];
P0o=P0; %definisco P0 omogeneo
P0o(:,4)=1;
N=P1-P0; %vettore normale al piano
versN=N/norm(N); %versore di N
disp("versN");
disp(versN);
versNo=versN;
versNo(:,4)=1;
disp("versNo");
disp(versNo);

%plot della b-spline in coordinate normali
p=1;
res=100;
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
bsl.createCurve(Pc,p,U,res);
title("b-spline");
view(3);

%TRASFORMAZIONE DI RIFLESSIONE
%devo definire la matrice identità e poi fare il ciclo for per la matrice
%di trasformazione

I=eye(3,3); %matrice identità
for i=1:length(Pc)
    d=(P0o-Pco(i,:))*versNo';
    rif=[2*d*versNo(1)
        2*d*versNo(2)
        2*d*versNo(3)
        ];
    T=I;
    T(:,4)=rif;
    T(4,4)=1; 
    Pcr(i,:)=T*Pco(i,:)';
end

Pcr(:,4)=[]; %elimino la 4a colonna per riportarlo alle coordinate normali

%plot curva riflessa
figure;
bsl.createCurve(Pcr,p,U,res);
title("b-spline riflessa");
view(3);


%% ESERCITAZIONE 4 - RIFLESSIONE

clc
clear all

%sono assegnati i Pc della b-spline. si suppone la curva piana (p=1) e
%appartenente al piano z=0

Pc=[-1 0 0;
    0.5 1 0;
   2 1 0;
   0.5 -1 0;
   2 -1 0;
   4 0.5 0;
   5 1 0;
   6 0.5 0;
   7 -1 0]; %terza coordinata nulla, perché è una curva piana
Pco=Pc;
Pco(:,4)=1; %Pc in coordinate omogenee Pco

%plot curva
n=size(Pc,1)-1;
p=1;
U=bsl.knotsNonPeriodic(n,p);
res=100;
figure;
bsl.createCurve(Pc,p,U,res);
title("b-spline");
view(3); %vediamo la curva in 3d

%calcolare la curva b-spline ottenuta mediante copia speculare rispetto al
%piano di equazione y=4

%dati piano
%piano in forma parametrica (P0, N)
%mi dice che l'eq del pi è y=4. ricavo P0 e N a partire da questo dato
%PUNTO: come punto P0 sul piano posso scegliere qualsiasi punto con y=4, ad
%esempio P0=(0,4,0)
%NORMALE: normale al piano y=4 -> N=(0,1,0)
P0=[0,4,0]; %punto del piano
P0o=P0;
P0o(:,4)=1; 
N=[0,1,0]; %normale al pi y=4
versN=N/norm(N);
versNo=versN;
versNo(:,4)=1;

%matrice di trasformazione
I=eye(3,3); %matrice identità
for i=1:length(Pc)
    d=(P0o-Pco(i,:))*versNo';
    rif=[2*d*versNo(1)
        2*d*versNo(2)
        2*d*versNo(3)
        ];
    T=I;
    T(:,4)=rif;
    T(4,4)=1;
    Pcr(i,:)=T*Pco(i,:)';
end
Pcr(:,4)=[]; %tolto la quarta riga, così lo riporto in coordinate normali

%plot curva riflessa
figure();
bsl.createCurve(Pcr,p,U,res);
title("curva riflessa");
view(3);

%% ESERCITAZIONE 5 - SCALA

clc
clear all

%calcola la curva b-spline con p=4 avente Pc. 
Pc=[0,0,0
    -0.5,1,0
    2,1,0
    0.5,1,0
    2,-1,0
    2.5,0.5,0
    ];

Pco=Pc;
Pco(:,4)=1;

%plot curva
p=4;
res=100;
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
subplot(1,2,1);
bsl.createCurve(Pc,p,U,res);
title("b-spline");


%calcola la curva trasformata mediante scala secondo i fattori Sxyz dati,
%rispetto al P0
%definire gli sxyz:
sx=0.5;
sy=0.25;
S=[sx,0,0,0
    0,sy,0,0
    0,0,1,0
    0,0,0,1
    ]; %matrice di scala
I=eye(3,3); %matrice identità
for i=1:length(Pc)
    T01=I;
    P0=[-2,1,0];
   % P0o=[-2,1,0,1]; %P0 omogeneo
    scal=P0;
    T01(:,4)=scal;
    T01(4,4)=1;
    T10=inv(T01);
    T=T01*S*T10;
    Pcs(i,:)=T*Pco(i,:)';
end

Pcs(:,4)=[]; %tolgo la coordinata omogenea

%plot curva scalata
subplot(1,2,2);
bsl.createCurve(Pcs,p,U,res);
title("curva scalata");

%% ESERCITAZIONE 6: SCALA-RIFLESSIONE

clc
clear all 

%è assegnato il vettore direzione V=[1,0,0] e P0=[3,0,0]
%calcola curva b-spline con p=5 avente Pc

Pc=[0,0,0
    -0.5,1,0
    2,1,0
    0.5,-1,0
    2,-1,0
    2.5,0.5,0
];
Pco=Pc;
Pco(:,4)=1; %Pc omogeneo

%plot curva
p=5;
res=100;
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);
subplot(1,3,1);
bsl.createCurve(Pc,p,U,res);
title("bspline");

%dati
V=[1,0,0];
versV=V/norm(V);
versVo=versV;
versVo(:,4)=1; %versVo omogeneo
P0=[3,0,0];
P0o=[3,0,0,1]; %P0 omogeneo


%calcola la curva trasformata mediante scala secondo i fattori dati,
%rispetto all'origine P0=[0,0,0]
I=eye(3,3); %matrice identità
sx=0.5;
sy=0.7;
sz=0.8;
S=[sx,0,0,0
    0,sy,0,0
    0,0,sz,0
    0,0,0,1
    ];
for i=1:length(Pc)
    scal=P0;
    T01=I;
    T01(:,4)=scal;
    T01(4,4)=1;
    T10=inv(T01);
    T=T01*S*T10;
    Pcs(i,:)=T*Pco(i,:)';
end

Pcs(:,4)=[]; %tolgo la coordinata omogenea

%plot curva scalata
subplot(1,3,2);
bsl.createCurve(Pcs,p,U,res);
title("scalata");

%effettuare la riflessione della curva
Pcso=Pcs;
Pcso(:,4)=1;
for i=1:length(Pcs)
    d=(P0o-Pcso(i,:))*versVo';
    rif=[2*d*versVo(1)
        2*d*versVo(2)
        2*d*versVo(3)
        ];
    T=I;
    T(:,4)=rif;
    T(4,4)=1;
    Pcr(i,:)=T*Pcso(i,:)';
end

Pcr(:,4)=[]; %tolgo la coordinata omogenea

%plot curva riflessa
subplot(1,3,3);
bsl.createCurve(Pcr,p,U,res);
title("riflessa");

%% ESERCITAZIONE 7: SCALA - TRASLAZIONE

clc
clear all

%calcola la bspline appartenente al pi z=0 e passante per i punti Q con p=3
%ed esportali in un file txt

Q=[-1,1,0
    0,0,0
    1,1,0
    2,2,0
    3,-1,0
    ]; %vettore dei punti da interpolare
p=3;
[Pc,U]=bsl.globalCurveInterp(Q,p);
Pco=Pc;
Pco(:,4)=1; %4a colonna di 1 per ottenere le coordinate omogenee

%plot della bspline
res=100;
bsl.createCurve(Pc,p,U,res);
title("bspline");
Pbs=bsl.getBsplinePoint(Pc,p,U,0,1,res);
bsl.writePointonFile("ex7_punti.txt",Pbs);

%calcola il numero di rami della curva 
Uk=bsl.getSpan(U); %calcolo gli intervalli del vettore dei nodi
numrami=length(Uk); %calcolo numero di rami

%scala la curva rispetto ai coeff s dati nel pi z=15
sx=0.5; 
sy=0.5;
sz=1;
S=[sx,0,0,0
    0,sy,0,0
    0,0,sz,0
    0,0,0,1
    ];
P0=[0,0,0]; %di solito la trasformazione di scala si fa rispetto all'origine
%degli assi
I=eye(3,3); 
for i=1:length(Pc)
    scal=P0; %scalo la curva rispetto all'origine
    T01=I;
    T01(:,4)=scal;
    T01(4,4)=1;
    T10=inv(T01);
    T=T01*S*T10;
    Pcs(i,:)=T*Pco(i,:)';
end

%ottengo Pcs in coordinate omogenee
Pcs(:,4)=[]; %tolgo la 4a coordinata

%plot curva scalata
%subplot(1,2,2);
figure;
bsl.createCurve(Pcs,p,U,res);
title("curva scalata");
view(3);

%devo traslare la curva nel pi z=15
Pcs(:,3)=15; %3a colonna tutti 15

%plot curva scalata e traslata
figure;
bsl.createCurve(Pcs,p,U,res);
title("curva scalata e traslata");
view(3);


%% ESERCITAZIONE 8: SCALA-TRASFORMATA

clc
clear all

%assegnati il vettore direzione V e il P1
V=[1,1,1]; 
P1=[0,0,0];

%costruisco una terna locale associata a V e a P1
versV=V/norm(V);
B=null(versV); %calcolo della base (nello spazio nullo) di versV
% null restituisce una matrice i cui colonne formano una base per lo spazio
% nullo di versV. ottengo una matrice composta da 2
% colonne, che sono i vettori ortogonali a versV
%Lo spazio nullo è l'insieme di tutti i vettori che moltiplicati per versV,
%danno zero con il prodotto scalare

%nel riferimento locale calcola la bspline di p=2 che ha Pc
Pc=[-1,1,0
    0,0,0
    1,1,0
    ];
Pco=Pc;
Pco(:,4)=1; %in coordinate omogenee
p=2; 
res=100;
n=size(Pc,1)-1;
U=bsl.knotsNonPeriodic(n,p);

%plot bspline
figure;
sgtitle("riferimento locale");
subplot(1,3,1);
bsl.createCurve(Pc,p,U,res);
title("bspline");

%calcolare il numero di rami della bspline
Uk=bsl.getSpan(U);

%calcolare i coseni direttori del vettore V
cos1=V(1)/norm(V);
cos2=V(2)/norm(V);
cos3=V(3)/norm(V);

%calcolare la curva scalata mediante trasformazione di scala coi seguenti
%fattori e appartenente al pi z=3
%ovvero devo fare la scala + traslazione in z=3
sx=0.5;
sy=0.3;
sz=0;
S=[sx,0,0,0
    0,sy,0,0
    0,0,sz,0
    0,0,0,1
    ]; %matrice di scala
I=eye(3,3); 

for i=1:length(Pc)
    scal=P1;
    T01=I;
    T01(:,4)=P1;
    T01(4,4)=1;
    T10=inv(T01);
    T=T01*S*T10;
    Pcso(i,:)=T*Pco(i,:)';
end

Pcs=Pcso;
Pcs(:,4)=[]; %tolgo la coordinata omogenea

%plot curva scalata
subplot(1,3,2);
bsl.createCurve(Pcs,p,U,res);
title("scalata");

%traslo la curva in z=3
Pcst=Pcs;
Pcst(:,3)=3; %3a colonna di 3

%plot curva scalata e traslata
subplot(1,3,3);
bsl.createCurve(Pcst,p,U,res);
title("scalata+traslata");

%calcola la trasformata delle due curve nel riferimento globale omega0
%matrice di trasformazione dalla terna locale a globale
T10=[versV',B(:,1),B(:,2)]; 
%quella da globale a locale è: T01=inv(T10);

%calcola la trasformata delle due curve nel riferimento globale omega0
%curva scalata
Pcs0=T10*Pcs'; %nel riferimento globale
%curva scalata e traslata
Pcst0=T10*Pcst';

%plot nel riferimento globale
%plot curva scalata nel riferimento globale 
figure;
sgtitle("riferimento globale");
subplot(1,2,1);
bsl.createCurve(Pcs0,p,U,res);
title("scalata");
%plot curva scalata+traslata nel riferimento globale
subplot(1,2,2);
bsl.createCurve(Pcst0,p,U,res);
title("scalata+traslata");

%esportare le curve bspline
%esporto curva scalata nel rif globale
Pbs=bsl.getBsplinePoint(Pcs0,p,U,0,1,res);
bsl.writePointonFile("scalata_punti.txt",Pbs);
%esporto curva scalata+traslata nel rif globale
Pbs=bsl.getBsplinePoint(Pcst0,p,U,0,1,res);
bsl.writePointonFile("scal_tras_punti.txt",Pbs);



