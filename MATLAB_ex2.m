%Siano assegnati il vettore direzione V=[1 1 1] ed il punto P0=[0 0 0]. 
%Creare la superficie conica retta il cui asse è definito dal vettore V e 
%dal punto P0. I raggi delle sezioni rette sono R1=100 mm ed R2=200 mm, 
%mentre gli angoli sottesi sono α1=130° ed α2=130°, rispettivamente. 
%L'altezza L è pari a 500 mm

clc
clear all

%DATI INIZIALI

%vettore direzione
V=[1,1,1]; %vettore
P0=[0,0,0]; %punto

%creare la sup conica retta il cui asse è definito da V e da P0
z=V/norm(V);
%calcolo una base ortonormale per z
%base ortonormale: Una base ortonormale è un insieme di vettori che sono 
%ortogonali tra loro e hanno norma 1. 
base=null(z); %ho usato lo spazio nullo per ricavare la base ortonormale
x=base(:,1); %estraggo i vettori x e y dalla base
y=base(:,2);
%i vettori x e y ottenuti da base=null(z) sono già normalizzati, perché
%fanno parte della base ortonormale
R1=100; %raggi delle sezioni rette
R2=200;
a=130; %angolo sotteso
a_rad=deg2rad(a); %angolo sotteso espresso in radianti
L=500;

%In ambiente di calcolo numerico (Matlab) utilizzare lo spazio nullo per 
%ricavare la terna solidale all'asse della superficie conica.

%Approssimare i due archi di circonferenza, Г1 ed Г2, con due curve B-Spline 
%di grado p=2. Esportare, quindi, le curve così calcolate in ambiente CAD e 
%generare la superficie di loft usando come profili le curve Г1 ed Г2 così importate.

%%CURVA GAMMA2

t=linspace(0,2*pi-a_rad); %linspace: per generare un vettore di punti distribuiti uniformemente tra due valori
%ho definito un set di punti della circonferenza da interpolare tramite la
%sua espressione parametrica
xGamma2=R2*cos(t);
yGamma2=R2*sin(t);
zGamma2=0*t;
Q2=[xGamma2',yGamma2',zGamma2']; %vettore dei punti da interpolare
p=2; %grado della curva b-spline
%uso la libreria bsl 
%e la funzione globalCurveInterp: interpola un set di punti con una curva
%b-spline di grado assegnato
[Pc2,U2]=bsl.globalCurveInterp(Q2,p);
%basta dare in input il vettore dei punti da interpolare Q
%e il grado della curva b-spline interpolante
%in output ottengo Pc e U. Pc: vettore dei punti di controllo
%U: vettore dei nodi

%immetto la risoluzione della curva b-spline: ovvero di quanti punti 
%dev'essere composta
res=100;
bsl.createCurve(Pc2,p,U2,res); %plotta la curva b-spline

%facciamo la trasformazione in coordinate da un sistema globale a uno
%locale
%attualmente la CURVA 2 è definita in un sistema di riferimento globale.
%noi ci vogliamo mettere nel sistema di riferimento solidale all'asse del
%cono
%MATRICE DI TRASFORMAZIONE
T2=[x,y,z',P0';0,0,0,1];

%il sistema di riferimento locale è definito da 
%P0:origine del cono. x,y,z:versori. z è trasposta. 
%ogni punto di controllo della CURVA 2 (ora in coordinate cartesiane 3d) 
%lo devo trasformare in coordinate omogenee, aggiungendo una quarta colonna
%di valore 1. lo devo fare perché la matrice di trasformazione T è 4x4,
Pc2o=Pc2;
Pc2o(:,4)=1; %trasformo la matrice dei punti di controllo in coordinate omogenee

%trasformare la matrice espressa in coordinare cartesiane in coordinate
%omogenee, significa aggiungere una quarta coordinata di valore 1

%applico la matrice di trasformazione.
%NOTA:.per svolgere la moltiplicazione, devo trasporre il vettore dei punti di controllo Pc2o 
Pc2ol=T2*Pc2o';

%traspongo la matrice
Pc2l=Pc2ol';
Pc2l(:,4)=[]; %dalle coordinate omogenee a cartesiane

%creo la curva in coordinate locali
bsl.createCurve(Pc2l,p,U2,res); %plotta la curva b-spline

%calcolo i punti della curva b-spline:
Pbs2=bsl.getBsplinePoint(Pc2l,p,U2,0,1,res); 

%esporta su file i punti della curva:
bsl.writePointonFile("Gamma2.txt",Pbs2);  

%%CURVA GAMMA1
