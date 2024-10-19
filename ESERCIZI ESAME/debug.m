clear
clc
% Dati iniziali
Pc=[0 0 0;-0.5 1 0;2 1 0;0.5 -1 0;2 -1 0;2.5 0.5 0];
P0=[-2 1 0];
P0o=[-2 1 0 1]; % Punto P0 in coordinate omogenee
V=[1 -2 1];
p=4;
res=100;
alfa=30; % Angolo di rotazione
alfarad=alfa*pi/180; % Angolo di rotazione in radianti
% Numero dei punti di controllo - 1
n=size(Pc,1)-1;
% Calcolo del versore normale
Vv=V/norm(V);
% Calcolo del vettore dei nodi della curva non ruotata
U=bsl.knotsNonPeriodic(n,p);
% Plot della curva non ruotata
subplot(1,2,1);
bsl.createCurve(Pc,p,U,res);
% A questo punto bisogna calcolare la matrice di rotazione. E' noto che:
% R=K(V)+cos(alpha)*[I-K(V)]+sin(alpha)*W(V)
% Con:
% K(V)=Prodotto di Kronecker di V. Esiste una fz dedicata
% |0 -Vz Vy|
% W(V)=|Vz 0 -Vx|
% |-Vy Vx 0 |
% Calcolo del prodotto di Kronecker
K=kron(Vv,Vv');
% Calcolo il tensore assiale del vettore V
W=[0 -Vv(3) Vv(2);Vv(3) 0 -Vv(1);-Vv(2) Vv(1) 0];
% Calcolo della matrice di rotazione (formula di Rodriques)
R=K+cos(alfarad)*(eye(3,3)-K)+sin(alfarad)*W;
R(4,4)=1;
% Calcolata la matrice di rotazione bisogna passare al calcolo della
% matrice di trasformazione complessiva [T]:
% T=T01*R*T10
% Con: T01=Matrice di trasformazione rigida, T10=Inversa(T01)
% Calcolo della matrice di trasformazione rigida e della sua inversa
T01=eye(4,4);
T01(:,4)=P0o'; %da locale a globale
T10=inv(T01); %da globale a locale
% Calcolo della matrice di trasformazione complessiva [T]
Pco=Pc;
Pco(:,4)=1;
PcLoc=T01*R*T10*Pco';
PcLoc=PcLoc';
PcLoc(:,4)=[];
% Plot curva
subplot(1,2,2);
bsl.createCurve(PcLoc,p,U,res);
% Calcolo dei punti della curva
Pbs=bsl.getBsplinePoint(PcLoc,p,U,0,1,res);
% Esportazione dei punti della curva in un file txt
bsl.writePointonFile('Esercizio8curvaRuotata.txt',Pbs)