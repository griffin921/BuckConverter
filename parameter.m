clear all
close all

%% Power Circuit Parameter
L = 500*10^-6;     %インダクタ[H]
RL = 10e-3;     %インダクタ直流抵抗[Ω]
C = 3000e-6;    %コンデンサ[F]
Load = 1;      %負荷抵抗[Ω]

fsw = 100e3;    %スイッチング周波数[Hz]

%% Current Plant Modeling
wc_c    = RL/L;             %折れ点周波数[rad]
fc_c    = wc_c / 2*pi;      %折れ点周波数[Hz]
Gain_c  = 1/RL;             %電流プラントゲイン
wc0_c   = wc_c * Gain_c;    %カットオフ周波数[Hz]
fc0_c   = fc_c * Gain_c;    %カットオフ周波数[Hz]
%% Voltage Plant Modeling
wc_v    = 1/C/Load;         %折れ点周波数[rad]
fc_v    = wc_v / 2*pi;      %折れ点周波数[Hz]
Gain_v  = Load;             %電圧プラントゲイン
wc0_v   = wc_v * Gain_v;    %カットオフ周波数[Hz]
fc0_v   = fc_v * Gain_v;    %カットオフ周波数[Hz]
%% Design of Voltage Controller
Kp_v  = Gain_v * 5;
Ki_v = Kp_v * wc_v;

%% Design of Current Controller
Kp_c = Gain_c * 1/50;
Ki_c = Kp_c * wc_c;

%% Transfer Function


s = tf('s');

% ------- Voltage Control---------------------------------- 
Voltage_plant = Gain_v * 1 / (1 / wc_v * s + 1 );

V_PI = (Kp_v * s + Ki_v) / s;

% ------- Current Control----------------------------------
Current_plant = Gain_c * 1 / (1 / wc_c * s + 1 );

C_PI = (Kp_c * s + Ki_c) / s;


%Plant & Controller Transfer Function
% figure(1)
% bodeplot(Voltage_plant);
% hold on;
% bodeplot(V_PI);
% figure(2)
% bodeplot(Current_plant);
% hold on;
% bodeplot(C_PI);
% %Open Loop Transfer Function
% figure(3)
% bodeplot(Voltage_plant * V_PI);
% hold on
% bodeplot(Current_plant * C_PI);



