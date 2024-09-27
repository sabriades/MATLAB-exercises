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
%blu per Q1 e rosso per Q2. figure:si imposta il riquadro
figure; 
%plotto tutte le righe della 1a colonna della Q1_traslata
%plotto tutte le righe della 2a colonna della Q2_traslata
%b:curva di colore blu 
%specifichiamo lo spessore della linea, con valore 2
plot(Q1_traslata(:,1),Q1_traslata(:,2),'b','LineWidth',2);
hold on; %i grafici dopo questo comando non sostituiranno,
%ma potranno coesistere coi precedenti
plot(Q2(:,1),Q2(:,2),'r','LineWidth',2);
hold off; %ripristina il comportamento precedente(cioè grafici che si sovrappongono)
%ETICHETTE:
xlabel('asse x');
ylabel('asse y');
title('RAPPRESENTAZIONE DELLE CURVE');
legend('Q1_traslata','Q2');
%grid on:aggiunge una griglia orizzontale e verticale al grafico
grid on; 

%%

%Ex8 
clc 
clear all

%vettore x1 e x2
x1=-3:0.2:1;
x2=-2:0.4:4;

%funzioni date
y1=x1.^2+2;
y2=-x2.^2-3;

%NOTA:. l'apice alle coordinate si usa per trasformare un vettore riga in
%un vettore colonna in questo caso

%MATRICI:
Q1=[x1',y1']; 
Q2=[x2',y2'];
%distanza minima:
min_dist=inf; %settiamo la distanza minima a infinito
puntomin_Q1=[0,0]; 
puntomin_Q2=[0,0];
%andiamo a confrontare ogni coppia di punti delle curve, per vedere quali
%danno la minima distanza 

%ciclo per trovare la distanza minima tra i punti di Q1 e Q2

for i=1:size(Q1,1) %size(Q1,1) mi dà il numero di righe della matrice
    for j=1:size(Q2,1) %size(Q2,1) numero di righe della matrice (per ottenere le colonne dovevo mettere size(Q2,2))
        %calcolo la distanza tra i punti
        dist=norm(Q1(i,:)-Q2(j,:)); %si considerano tutte le righe e tutte le colonne delle matrici
        %calcolo distanza tramite norma euclidea
        if dist<min_dist %dist dev'essere minore. l'altro è infinito
            min_dist=dist; %aggiorno la distanza minima con quella trovata
            puntomin_Q1=Q1(i,:); %si riaggiornano i valori dei punti definiti prima
            puntomin_Q2=Q2(j,:);
        end
    end
end

%rappresentazione grafica delle curve
figure; %creo il riquadro
hold on; 
plot(Q1(:,1),Q1(:,2),'b','LineWidth',2); %plotto Q1
plot(Q2(:,1),Q2(:,2),'r','LineWidth',2); %plottoQ2
%congiungente (in verde) dei punti con distanza minima:
plot([puntomin_Q1(1),puntomin_Q2(1)],[puntomin_Q1(2),puntomin_Q2(2)],'g','LineWidth',2);
%puntomin_Q1(1) coordinata x del punto Q1
%puntomin_Q1(2) coordinate y del punto Q1
%ETICHETTE:
xlabel('asse x');
ylabel('asse y');
title('DISTANZA MINIMA TRA LE CURVE');
legend('CURVA Q1','CURVA Q2','CONGIUNGENTE');
grid on; %aggiunge la griglia
hold off;

%

%Ex9 - calcolare il versore della congiungente dei due punti puntomin_Q1 e
%puntomin_Q2

%vettore congiungente
vetC=puntomin_Q1-puntomin_Q2;
%calcolo della norma del vettore:lunghezza del vettore
norm_vetC=norm(vetC);
%calcolo versore congiungente
verC=vetC/norm_vetC;

%stampa versore congiungente
disp('Versore congiungente:');
disp(verC);

%%

%Ex10 -

N1=[1,1,0];
N2=[0,1,0];
norm_N1=norm(N1);
norm_N2=norm(N2);
