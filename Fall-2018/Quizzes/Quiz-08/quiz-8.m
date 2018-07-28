% Kathryn Atherton
% ABE 301
% Quiz 8
% 03/05/2018

p = [136; 145; 153.5; 161.4; 168.5; 175.3; 186.5; 195.6; 200.5; 204.9; 209.5; 213.5; 216.4; 218.9; 221.3; 223.4; 225; 225.5; 225.1; 222.7; 220; 216.6; 213.7; 210.7; 208.6; 205.5; 202];
l = [0; 0.025; 0.05; 0.075; 0.1; 0.125; 0.175; 0.231; 0.27; 0.3121; 0.37; 0.409; 0.445; 0.486; 0.5349; 0.5912; 0.65; 0.715; 0.7597; 0.8289; 0.87; 0.9058; 0.935; 0.9565; 0.97; 0.985; 1];
v = [0; 0.1; 0.2; 0.3; 0.37; 0.43; 0.51; 0.55; 0.58; 0.60; 0.62; 0.63; 0.64; 0.65; 0.66; 0.67; 0.68; 0.69; 0.70; 0.72; 0.75; 0.79; 0.81; 0.85; 0.87; 0.91; 1];

%% Part A 
% cubic spline models

n = len(p);
m = n - 1;

h_l = zeros(m, 1); % interval sizes - liquid
for i = 1:m; 
	h_l(i, 1) = l(i + 1) - l(i);
end

h_v = zeros(m, 1); % interval sizes - vapor
for i = 1:m;
	h_v(i, 1) = v(i + 1) - v(i);
end

a = p; % a coefficients, both liquid & vapor

Avector_l = zeros(n, 1); %ci coefficients - liquid
for i = 2:m
	Avector_l(i, 1) = 3 * (a(i + 1) - a(i)) / h_l(i) - 3 * (a(i) - a(i - 1)) / h_l(i - 1);
end

Avector_v = zeros(n,1); %ci coefficients - vapor
for i = 2:m
	Avector_v(i, 1) = 3 * (a(i + 1) - a(i)) / h_v(i) - 3 * (a(i) - a(i - 1)) / h_v(i - 1);
end

Hmatrix_l = zeros(n, n); % c coefficients setup - liquid
Hmatrix_l(1, 1) = 1;
Hmatrix_l(n, n) = 1;

for i = 2:m 
	Hmatrix_l(i, i - 1) = h_l(i - 1);
	Hmatrix_l(i, i) = 2 * (h_l(i - 1) + h_v(i));
	Hmatrix_l(i, i + 1) = h_l(i);
end

Hinv_l = inv(Hmatrix_l);


Hmatrix_v = zeros(n, n); % c coefficients setup - vapor
Hmatrix_v(1, 1) = 1;
Hmatrix_v(n, n) = 1;

for i = 2:m 
	Hmatrix_v(i, i - 1) = h_v(i - 1);
	Hmatrix_v(i, i) = 2 * (h_v(i - 1) + h_v(i));
	Hmatrix_v(i, i + 1) = h_v(i);
end

Hinv_v = inv(Hmatrix_v);

c_l = Hinv_l * Avector_l; % c coefficients - liquid (terminal valuse are zero for natural cubic spline)

c_v = Hinv_v * Avector_v; % c coefficients - vapor

b_l = zeros(m, 1); % b coefficients - liquid
for i = 1:m 
	b_l(i, 1) = ((a(i + 1) - a(i)) / h_l(i)) - (((c_l(i + 1) + 2 * c_l(i)) * h_l(i)) / 3);
end

b_v = zeros(m, 1); % b coefficients - vapor
for i = 1:m 
	b_v(i, 1) = ((a(i + 1) - a(i)) / h_v(i)) - (((c_v(i + 1) + 2 * c_v(i)) * h_v(i)) / 3);
end

d_l = zeros(m, 1); % d coefficients - liquid
for i = 1:m 
	d_l(i, 1) = (c_l(i + 1) - c_l(i)) / (3 * h_l(i));
end

d_v = zeros(m, 1); % d coefficients - vapor
for i = 1:m 
	d_v(i, 1) = (c_v(i + 1) - c_v(i)) / (3 * h_v(i));
end


% plot cubic spline models

figure('Name', 'P vs. Composition');
for i = 1:m 
	x_l = l(i):0.0001:l(i + 1);
	spline_l = (a(i, 1)) + (b_l(i, 1) .* (x_l - l(i))) + (c_l(i, 1) .* (x_l - l(i)) .^ 2) + (d_l(i, 1) .* (x_l - l(i)) .^ 3);
	plot(x_l, spline, 'r-');
	hold on;
end

for i = 1:m 
	x_v = v(i):0.0001:v(i + 1);
	spline_v = (a(i, 1)) + (b_v(i, 1) .* (x_v - v(i))) + (c_v(i, 1) .* (x_v - v(i)) .^ 2) + (d_v(i, 1) .* (x_v - v(i)) .^ 3);
	plot(x_l, spline, 'b-');
	hold on;
end
hold off;
title('P vs. Composition');
xlim([0,1]);
ylim([135,226]);
xlabel('mole fraction [-]');
ylabel('pressure [mmHg]');
































