clear all
close all

%% Power Circuit Parameter
L = 200*10^-6;     %インダクタ[H]
RL = 10e-3;     %インダクタ直流抵抗[Ω]
C = 3000e-6;    %コンデンサ[F]
Load = 2;      %負荷抵抗[Ω]

fsw = 200e3;    %スイッチング周波数[Hz]

%% Current Plant Modeling
wc_c    = RL/L;            %カットオフ周波数[rad]
fc_c    = wc_c / 2*pi;     %カットオフ周波数[Hz]
Gain_c  = 1/RL;          %電流プラントゲイン

%% Voltage Plant Modeling
wc_v    = 1/C/Load;            %カットオフ周波数[rad]
fc_v    = wc_v / 2*pi;     %カットオフ周波数[Hz]
Gain_v  = Load;          %電流プラントゲイン


%% Design of Voltage Controller
Kp_v  = Gain_v;
Ki_v = Kp_v * wc_v;

%% Design of Current Controller
Kp_c = Gain_c;
Ki_c = Kp_c * wc_c;

%% Transfer Function


s = tf('s');

% ------- Voltage Control---------------------------------- 
Voltage_plant = 1 / C * 1 / (s + 1 / (Load * C));

V_PI = (Kp_v * s + Ki_v) / s;

% ------- Current Control----------------------------------
Current_plant = 1 / L * 1 / (s + 1 / (L * RL) );

C_PI = (Kp_c * s + Ki_c) / s;

% 
% %Plant & Controller Transfer Function
% figure(1)
% bodeplot(Voltage_plant);
% hold on;
% bodeplot(V_PI);
% 
% %Open Loop Transfer Function
% figure(2)
% bodeplot(Voltage_plant * V_PI);
% hold on
% bodeplot(Current_plant * C_PI);
% 
% %Direct Voltage Plant Model
% figure(3)
% step( V_PI * Voltage_plant /( 1 + V_PI*Voltage_plant ) );

