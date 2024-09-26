clc
clear 
%%
clc
clear all 

%Ex1 - inizializzare matrice 4x4 con tutti elementi nulli

A(4,4)=0; 

%alternatively:
B=zeros(4,4);

%%

%Ex2 - crea matrice 4x4 con elementi unitari sulla diagonale principale
clc
clear all 

C(4,4)=0;

C(1,1)=1;
C(2,2)=1;
C(3,3)=1;
C(4,4)=1;

%alternatively:
D(4,4)=0;
for i=1:4
    D(i,i)=1;
end

%alternatively: 
E=eye(4,4); 

%%

%Ex3 - crea matrice 10x4 popolata con una distribuzione uniforme di numeri
%interi (casuali) compresi tra 0 e 5
clc
clear all

F=round(5*rand(10,4));

%alternatively: 
G=randi([0,5],10,4); 

%%

%Ex4 - Dalla matrice A o B generata nell’esercizio 3, prelevare la sottomatrice 
% costituita dalle righe dispari e dalle prime tre colonne. Successivamente, 
% eseguire il plot dei dati assumendo che ogni riga rappresenta un punto nello 
% spazio euclideo. Assegnare una linea continua rossa e una sfera di colore 
% rosso a ogni punto.

clc
clear all

C=randi([0,5],10,4);

l=size(C,1) %estraggo il numero di righe di C nella prima colonna
k=0; %inizializzo la variabile k
for i=1:2:l %inizio da 1, passo 2, si finisce quando si arriva a l
    k=k+1
    D(k,:)=C(i,:)
end
D(:,4)=[] %elimino la 4a colonna
plot3(D(:,1), D(:,2), D(:,3), 'r-', 'LineWidth', 2, 'Marker', 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8)

%%

%Ex5 - dati due punti, calcola la distanza tra essi
clc
clear all 

P1=[1,2,1];
P2=[5,3,3];
D=P2-P1; %distanza tra i due punti
d=norm(D) %la distanza è la norma del vettore D

%%

%Ex6 - per i due P assegnati nell'ex5, calcola la 
%distanza lungo la direzione definita da N

clc
clear all 
P1=[1,2,1];
P2=[5,3,3];
D=P2-P1;
N=[1,2,2];
vers_N=N/norm(N); %versore di N
d_n=D*vers_N'; %la distanza lungo N è prod scalare fra D e vers_N


%%

%Ex7

clc
clear all
%vettore1 e 2
x1=-3:0.2:1;
x2=-2:0.4:4;

%funzioni date
y1=x1.^2+2;
y2=-x2.^2-3;

Q1=[x1',y1']; %matrice Q1 con coordinate (x1, y1)
Q2=[x2',y2']; %matrice Q2 con coordinate (x2, y2)

%visualizzo Q1 e Q2:
disp('Matrice Q1:');
disp(Q1);
disp('Matrice Q2:');
disp(Q2);

%traslo Q1 di -2 lungo x e -2 lungo y
Q1_traslata = Q1 - [2, 2];

%devo rappresentare le curve nella stessa area grafica
%blu per Q1 e rosso per Q2
figure; 
title("RAPPRESENTAZIONE CURVE");
