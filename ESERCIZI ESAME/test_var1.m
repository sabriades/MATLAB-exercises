%% Esercitazione 16: variazione 1
clc; 
clear;

% Definizione dei dati
d = [126, -27, 15]; % distanza tra la terna omega2 e l'estremo superiore dell'asse della boccola 12
R = eye(3); % Matrice identità per la rotazione
T2_12 = [R, d'; 0, 0, 0, 1]; % Trasformazione tra boccola 12 e omega2

% Angolo in gradi e radiante
g_gradi = -0.2;
g = -g_gradi * (pi / 180); % Conversione in radianti

% Definizione dello spostamento in mm
dx = 0.2; % mm

% Matrice di trasformazione variazione
Tv = [1, -g, 0, dx;
      g, 1, 0, 0;
      0, 0, 1, 0;
      0, 0, 0, 1];

% Matrice di trasformazione aggiuntiva (identità)
Ta = eye(4);

% Trasformazioni finali con e senza variazioni
Tvar = T2_12 * Tv * Ta;
Tnvar = T2_12;

% Estremi nella boccola nel sistema 2 in coordinate omogenee
Ptop = [0, 0, 0, 1];
P2 = [0, 0, -20, 1];

% Estremi in omega2 senza variazione
Ptop2_nv = Tnvar * Ptop';
Pbot2_nv = Tnvar * P2';

% Estremi in omega2 con variazione
Ptop2_v = Tvar * Ptop';
Pbot2_v = Tvar * P2';

% Spostamento dei punti tangenti alla superficie cilindrica esterna della boccola
P1 = [8, 8, 0, 1];
P2 = [8, 8, -20, 1];

% Estremi senza variazione
P1_2_nv = Tnvar * P1';
P2_2_nv = Tnvar * P2';

% Estremi con variazione
P1_2_v = Tvar * P1';
P2_2_v = Tvar * P2';

% plot dei risultati
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
