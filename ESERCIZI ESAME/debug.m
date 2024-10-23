clc
clear all

Pc=[0 0 0
1 2 3
2 5 4
7 6 5
4 8 6
9 5 2];
P2=[1 0 1];
P1=[0 1 1];
V=[1 1 1];
%Creo matrice di trasformazione che mi consente di passare da P2 a P1 (in
%questo caso è una matrice di pura traslazione)
T12=eye(4,4);
%il vettore traslazione presenterà come componenti le coordinate
%dell'origine della terna P2 rispetto a P1
T12(1:3,4)=P2';
%Nota questa prima matrice di trasformazione passo alla seconda. Per farlo
%uso lo spazio nullo per ottenere il versore:
v=V/norm(V);
%Calcolo la base "B":
B=null(v);
%Ricavo la terna:
terna=[B(:,1) B(:,2) v'];
%La matrice di trasformazione sarà:
T01=eye(4,4);
%Matrice di rotazione:
T01(1:3,1:3)=terna;
%Come vettore traslazione avremo le coordinate dell'origine della terna P1
T01(1:3,4)=P1';

T01

%Matrice di trasformazione complessiva
T=T01*T12;
Pc(:,4)=1;
Pc_trasf=T*Pc';
Pc_trasf
Pc_trasf(4,:)=[];
Pc_trasf=Pc_trasf';
%Adesso conosco i punti di controllo nella terna omega con 0
%Ora plotto
p=3; %la suggerisce il prof al momento
res=100; %la assegno io
n=size(Pc_trasf,1)-1;
U=bsl.knotsNonPeriodic(n,p);
f=figure;
bsl.createCurve(Pc,p,U,res);
%view(3);