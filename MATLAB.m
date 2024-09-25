clc
clear 
%%

%Ex1 - inizializzare matrice 4x4 con tutti elementi nulli
%initialize 4x4 matrix with all null elements
A(4,4)=0; 
%alternatively:
B=zeros(4,4);

%%

%Ex2 - crea matrice 4x4 con elementi unitari sulla diagonale principale
%create 4x4 matrix with unit elements on the main diagonal
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
%eng - creates a 10x4 matrix populated with a uniform distribution of 
%(random) integers between 0 and 5

F=round(5*rand(10,4));

%alternatively: 
G=randi([0,5],10,4); 



