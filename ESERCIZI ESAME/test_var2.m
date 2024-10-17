%% Esercitazione 16: variazione 2
clc; clear;

% Angolo in gradi e conversione in radianti
g_g = 0.4; % gradi intorno all'asse x di 10T
g = g_g * pi / 180; % conversione in radianti

% Traslazioni lungo gli assi
dx = 0.1; % terna 2
dy = 0.1; % terna 2

% Distanza tra i punti della terna 2 e 10
d2_10 = [112, 13, 27];

% Matrice identità per la rotazione
R = eye(3);

% Trasformazione tra la terna 2 e 10
T2_10 = [R, d2_10'; 0, 0, 0, 1];

% Matrice di rotazione (variazione)
Tv_rot = [1, 0, 0, 0;
          0, 1, -g, 0;
          0, g, 1, 0;
          0, 0, 0, 1];

% Matrice identità
TA = eye(4);

% Distanza tra i punti della terna 1 e 2
d1_2 = [-16, 65, 90];
T1_2 = [R, d1_2'; 0, 0, 0, 1];

% Vettore di traslazione
dv = [dx, dy, 0];

% Matrice di traslazione
Tv_trasl = [eye(3), dv'; 0, 0, 0, 1];

% Trasformazioni finali con variazione e senza variazione
T1_10_var = T1_2 * Tv_trasl * TA * T2_10 * Tv_rot;
T1_10_nv = T1_2 * TA * T2_10;

% Estremi nella boccola nel sistema 2 in coordinate omogenee
Ptop = [0, 0, 0, 1];
Pbot = [0, 0, -40, 1];

% Estremi in omega2 senza variazione
Ptop2_nv = T1_10_nv * Ptop';
Pbot2_nv = T1_10_nv * Pbot';

% Estremi in omega2 con variazione
Ptop2_v = T1_10_var * Ptop';
Pbot2_v = T1_10_var * Pbot';

% Spostamento dei punti tangenti alla superficie cilindrica esterna della boccola
P1 = [12.5, 12.5, 0, 1];
P2 = [12.5, 12.5, -40, 1];

% Estremi senza variazione
P1_2_nv = T1_10_nv * P1';
P2_2_nv = T1_10_nv * P2';

% Estremi con variazione
P1_2_v = T1_10_var * P1';
P2_2_v = T1_10_var * P2';

% Plot dei risultati
figure;
plot3([Ptop2_v(1), Pbot2_v(1)], [Ptop2_v(2), Pbot2_v(2)], [Ptop2_v(3), Pbot2_v(3)], 'g', 'LineWidth', 2); hold on;
grid on;
plot3([Ptop2_nv(1), Pbot2_nv(1)], [Ptop2_nv(2), Pbot2_nv(2)], [Ptop2_nv(3), Pbot2_nv(3)], 'r', 'LineWidth', 2);

% Impostazione della legenda
legend('Con variazioni', 'Senza variazioni');

% Titolo e etichette degli assi
title('Variazione degli estremi nella boccola');
xlabel('X');
ylabel('Y');
zlabel('Z');
