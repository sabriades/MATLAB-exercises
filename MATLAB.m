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
D=P2-P1;
d=norm(D)




