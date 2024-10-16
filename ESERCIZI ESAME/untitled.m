clear
clc
% Dati iniziali
P0=[-2 1 0];
Pc=[0 0 0;-0.5 1 0;2 1 0;0.5 -1 0;2 -1 0;2.5 0.5 0];
Sx=0.5;
Sy=0.25;
p=4; % Grado della curva
% Risoluzione
res=100;
% Numero di punti di controllo - 1
n=size(Pc,1)-1;
% Calcolo del vettore dei nodi della curva non scalata
U=bsl.knotsNonPeriodic(n,p);
% Creazione spazio grafico
subplot(1,2,1)
% Plot curva non scalata
bsl.createCurve(Pc,p,U,res);
% Assegnazione di un titolo alla curva
title('B-Spline')
% Se l'operazione di riflessione si limitasse ad una riflessione rispetto
% all'origine, allora per calcolare il vettore dei punti di controllo
% scalati basterebbe fare il prodotto tra il vettore dei punti di controllo
% non scalati e la matrice di trasformazione di scala:
% Pcscala=S*Pco';
% Con:S=Matrice di trasformazione di scala
% Visto che la trasformazione di scala deve avvenire rispetto al punto P0,
% di conseguenza la relazione precedente diventa:
% Pcscala=T01*S*T10*Pco'
% Con: T01=Matrice di trasformazione per passare in P0, T10=Inversa(T01)
% In particolare:
% |1 0 0 P0x|
% T01=|0 1 0 P0y|
% |0 0 1 P0z|
% |0 0 0 1 |

% Per costruire questa matrice bisogna utilizzare una matrice identità
% [3x3] e un vettore colonna che contenga P0x, P0y,P0z.
% Matrice di scala rispetto all'origine degli assi
S=[Sx 0 0 0;0 Sy 0 0; 0 0 1 0;0 0 0 1];
% Calcolo della matrice di trasformazione per traslare in P0
T01=eye(3,3);
T01(:,4)=P0';
T01(4,4)=1;
T10=inv(T01);
% Passaggio alle coordinate omogenee
Pco=Pc;
Pco(:,4)=1;
% Calcolo trasformazione di scala in P0
Pcscala=T01*S*T10*Pco';
% Da questo calcolo si tottiene una matrice [4x6] a cui bisogna rimuovere
% la 4a riga
Pcscala(4,:)=[];
% In alternativa si sarebbe potuto usare un ciclo for
% for i=1:size(Pc,1)
% Pcscala(:,i)=T01*S*T10*[Pco(i,:)]';
% ................................;
% ................................;
% end
% Creazione spazio grafico
subplot(1,2,2)
% Plot della curva B-Spline scalata
bsl.createCurve(Pcscala',p,U,res); % bisogna avere una [6x3]
% Assegnazione di un titolo alla curva
title('bsplineScalata');
