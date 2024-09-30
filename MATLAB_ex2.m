%Siano assegnati il vettore direzione V=[1 1 1] ed il punto P0=[0 0 0]. 
%Creare la superficie conica retta il cui asse è definito dal vettore V e 
% dal punto P0. I raggi delle sezioni rette sono R1=100 mm ed R2=200 mm, 
% mentre gli angoli sottesi sono α1=130° ed α2=130°, rispettivamente. 
% L'altezza L è pari a 500 mm

clc
clear all

%vettore direzione
V=[1,1,1]; %vettore
P0=[0,0,0]; %punto

%creare la sup conica retta il cui asse è definito da V e da P0
z=V/norm(V);
%calcolo una base ortonormale per z
%base ortonormale: Una base ortonormale è un insieme di vettori che sono 
%ortogonali tra loro e hanno norma 1. 
base=null(z);
x=base(:,1); %estraggo i vettori x e y dalla base
y=base(:,2);
%i vettori x e y ottenuti da base=null(z) sono già normalizzati, perché
%fanno parte della base ortonormale

