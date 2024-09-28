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

%Ex10 

clc %pulisce la command window
clear all %cancella le variabili memorizzate

%vettore x1 e x2
x1=-3:0.2:1;
x2=-2:0.4:4;

%funzioni date
y1=x1.^2+2;
y2=-x2.^2-3;

%MATRICI:
Q1=[x1',y1']; 
Q2=[x2',y2'];
%matrici Q1 e Q2 che rappresentano le curve nello spazio 2d 

%vettori dati:
N1=[1,1,0];
N2=[0,1,0];
%devo proiettare la distanza tra i punti delle curve Q1 e Q2 lungo i vettori N1 e N2 

%norma:
norm_N1=norm(N1);
norm_N2=norm(N2);
%lunghezze dei vettori N1 e N2 necessarie per trasformare i vettori in
%versori (quindi vettori di lunghezza unitaria)

%calcolo dei rispettivi versori: 
vers_N1=N1/norm_N1;
vers_N2=N2/norm_N2;

%adatto le matrici Q1 e Q2 (in dimensione) ai vettori N1 e N2
Q1(:,3)=0; %si aggiunge la colonna di z=0
Q2(:,3)=0;
%infatti i vettori N1 e N2 hanno 3 componenti e quindi devo adattare Q1 e
%Q2 per includere la terza colonna z con valori tutti nulli

%NOTA:. i vettori N1 e N2 hanno 3 colonne e una riga
%CALCOLO DISTANZE MINIME di Q1 e Q2 lungo N1 e N2
distmin_N1=inf;
distmin_N2=inf;
%ho inizializzato le distanze minime con valore infinite e la distanza
%minima sarà inferiore: un qualsiasi valore reale minore di infinito

%inizializzo i punti della Q1 e Q2 (lungo N1 e N2) con distanza min 
puntoQ1_minN1=[];
puntoQ1_minN2=[];
puntoQ2_minN1=[];
puntoQ2_minN2=[];
%ho creato dei "contenitori" nulli per i punti che andiamo a calcolare

%loop per calcolare la distanza tra ogni punto di Q1 e Q2
for i=1:size(Q1,1) %loop per ogni punto di Q1
    for j=1:size(Q2,1) %loop per ogni punto di Q2
        %vettore differenza tra Q2 e Q1
        vett_diff=Q2(j,:)-Q1(i,:);
        %proietto il vettore differenza lungo le direzioni N1 e N2
        proj_N1=abs(dot(vett_diff,vers_N1));
        proj_N2=abs(dot(vett_diff,vers_N2));
%dot:calcola il prodotto scalare tra due vettori, quindi sto moltiplicando
%scalarmente il vettore differenza per il versore N1 e N2
%abs:valore assoluto (del risultato). cioè si fa il valore assoluto del
%risultato del prodotto scalare

%aggiorno la distanza minima lungo N1
if proj_N1<distmin_N1 
    distmin_N1=proj_N1;
    %puntoQ_minN è un valore che si riaggiorna ogni volta, finché non
    %troviamo il punto che dà la distanza minima (proiettata lungo le direzioni N) e allora
    %quella resterà come ultimo valore
    puntoQ1_minN1=Q1(i,:);
    puntoQ2_minN1=Q2(j,:);
end
%aggiorno la distanza minima lungo N2
if proj_N2<distmin_N2
    distmin_N2=proj_N2;
    puntoQ1_minN2=Q1(i,:);
    puntoQ2_minN2=Q2(j,:);
end
end
end

%confronta le distanze minime tra N1 e N2
if distmin_N1<distmin_N2
    distmin=distmin_N1;
    dir_min='N1';
    puntomin_Q1=puntoQ1_minN1;
    puntomin_Q2=puntoQ2_minN1;
else 
    distmin=distmin_N2;
    dir_min='N2';
    puntomin_Q1=puntoQ1_minN2;
    puntomin_Q2=puntoQ2_minN2;
end

%Stampa i risultati
disp(['La distanza minima tra le curve è: ', num2str(distmin)]);
disp(['Si ottiene lungo la direzione: ', dir_min]);
disp(['Il punto su Q1 corrispondente è: (', num2str(puntomin_Q1), ')']);
disp(['Il punto su Q2 corrispondente è: (', num2str(puntomin_Q2), ')']);

%%

%Ex11 

clc
clear all

%punto e vettore dato
P1 = [2, 2, 1];
N = [1, 1, 2];

%calcolo versN
versN=N/norm(N);

%calcolo z: z dev'essere orientato lungo la direzione N, quindi lungo il

%versore di N versN
z=versN;

%x e y, secondo la traccia, devono essere individuati dalla normale N.
%significa che x e y sono ortogonali a z (perché z è nella direzione di N)
%ricordiamo che per assicurarci che x (o y) e z siano ortogonali tra loro,
%devo fare il prodotto scalare ed esso deve risultare nullo

%prendo un vettore x arbitrario
x_temp=[1,0,0];
%calcolando il prodotto vettoriale tra x_temp e z, trovo un
%vettore ortogonale a z e x_temp

%prodotto vettoriale tra x_temp e z:
x=cross(x_temp,z);

%normalizzo x quindi lo rendo vettore unitario
x=x/norm(x);

%verifico che il prodotto scalare tra x e z sia nullo (ciò significa che x è ortogonale a z)
prod_scal=dot(x,z);
if prod_scal==0
    disp('x e z sono ortogonali')
end

%y deve essere ortogonale a x e z
y=cross(z,x); %prodotto vettoriale
disp('y e z ortogonali');

%verifica che x e y siano ortogonali a N (e quindi abbiano normale N)
verifica_x=dot(x,N); %se tali prodotti scalari sono nulli, allora x e y sono ortogonali a N
verifica_y=dot(y,N);
if verifica_x==0 && verifica_y==0
disp('x e y hanno normale N')
else
    error('x e y non hanno normale N')
end

%verifico che la terna sia levogira
v=cross(x,y);

%prodotto scalare che deve uscire >0 se la terna è levogira
%se prodotto scalare<0 allora la terna e destrogira
verifica_lev=dot(v,z);
if verifica_lev>0
    disp('la terna (x,y,z) è levogira')
else 
    error('la terna (x,y,z) non è levogira')
end 

%il piano che passa per il punto P1 ha normale N. possiamo considerare 
% tale piano come infinito e che perciò comprende P1 e tutti i punti che si ottengono come
% combinazioni lineari dei vettori x e y.  avendo x e y normale N, come verificato, 
% significa che già passano per il piano P1, quindi non c'è bisogno di
% verificare esplicitamente che passino per P1

%%

%Ex12

clc
clear all

P1=[0,1,0];
N=[2,2,0];

%determinare una terna levogira con asse y orientato lungo N
versN=N/norm(N);
y=versN; %y lungo N

%vettore x temporaneo
x_temp=[1,0,0];
%ci serve per fare il prodotto vettoriale
x=cross(x_temp,y);

%normalizzo x: lo rendo vettore unitario (versore)
x=x/norm(x);

%verifico che x sia ortogonale a y
%se x ortogonale a y, allora il prodotto scalare tra loro dev'essere nullo
%prodotto scalare:
prod_scalxy=dot(x,y);
if prod_scalxy==0
    disp('x e y sono ortogonali tra loro')
end

%calcolo z tramite il prodotto vettoriale
z=cross(y,x);
%allora z è ortogonale sia a x che y

%normalizzo z: lo rendo versore
z=z/norm(z);

%verifico che z sia ortogonale a x e y
prod_scalzx=dot(z,x);
prod_scalyz=dot(y,z);
if prod_scalyz==0 && prod_scalzx==0
    disp('z è ortogonale a x e y')
end

%verifico che la terna (x,y,z) sia levogira
v=cross(x,z); %vettore v ottenuto tramite prodotto vettoriale
%faccio il prodotto scalare di v con y
ver_lev=dot(v,y);
if ver_lev>0
    disp('la terna (x,y,z) è levogira')
end








