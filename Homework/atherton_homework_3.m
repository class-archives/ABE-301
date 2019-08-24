%% Homework 3
% Kathryn Atherton
% ABE 303
% February 25, 2019

%% Part A
P = [136, 145, 153.5, 161.4, 168.5, 175.3, 186.5, 195.6, 200.5, 204.9, 209.5, 213.5, ...
    216.4, 218.9, 221.3, 223.4, 225, 225.5, 225.1, 222.7, 220, 216.6, 213.7, 210.7, ...
    208.6, 205.5, 202];
L = [0, 0.025, 0.05, 0.075, 0.1, 0.125, 0.175, 0.231, 0.27, 0.3121, 0.37, 0.409, 0.445,...
    0.486, 0.5349, 0.5912, 0.65, 0.715, 0.7597, 0.8289, 0.87, 0.9058, 0.935, 0.9565, ...
    0.97, 0.985, 1];
V = [0, 0.1, 0.2, 0.3, 0.37, 0.43, 0.51, 0.55, 0.58, 0.60, 0.62, 0.63, 0.64, 0.65, 0.66,...
    0.67, 0.68, 0.69, 0.70, 0.72, 0.75, 0.79, 0.81, 0.85, 0.87, 0.91, 1];

fprintf('Spline Equations for Vapor Content:')
PV = cubic_spline(V,P);
hold on;
fprintf('Spline Equations for Liquid Content:')
PL = cubic_spline(L,P);
hold off;
title({'Pressure vs. Water Molar Composition';'(blue circles = vapor, red circles = liquid)'})
xlabel('Water (Liquid/Vapor) Molar Composition [mol/L]')
ylabel('Pressure [mmHg]')

%% Part B
error_tol = 0.001;
syms x
vapor_f = 108.26 * x - 190.87 * (x - 0.43) ^ 2 + 7345.5 * (x - 0.43) ^ 3 + 128.75 - 180;
vapor_x1 = 0.43;
vapor_p1 = double(subs(vapor_f,x,vapor_x1));
vapor_x2 = 0.51;
vapor_p2 = double(subs(vapor_f,x,vapor_x2));

vapor_root = bisection(vapor_f, vapor_x1, vapor_p1, vapor_x2, vapor_p2, error_tol)

liquid_f = 259.57 * x - 772.45 * (x - 0.125) ^ 2 + 1221.6 * (x - 0.125)^ 3 + 142.85 - 180;
liquid_x1 = 0.125;
liquid_p1 = double(subs(liquid_f,x,liquid_x1));
liquid_x2 = 0.175;
liquid_p2 = double(subs(liquid_f,x,liquid_x2));

liquid_root = bisection(liquid_f, liquid_x1, liquid_p1, liquid_x2, liquid_p2, error_tol)

%% Part C
% See pdf or physical copy for work

%% Functions
function S = cubic_spline(x1, y)
m = length(x1);
n = length(y);

if m ~= n
    error('Error: x and y have different dimensions.');
elseif m < 3
    error('Error: not enough points to create a cubic spline.');
else
    scatter(x1,y);
    hold on;
    [A, B, C, D] = spline_coeff(x1,y); 
    S = zeros(m, 1);
    for i = 1:m-1
        a = double(A(i));
        b = double(B(i));
        c = double(C(i));
        d = double(D(i));
        digits(5)
        syms x
        fprintf('Valid from x = %.4f to %.4f', x1(i), x1(i + 1))
        f = vpa(a) + (vpa(b) * (x - vpa(x1(i)))) + (vpa(c) * ((x - vpa(x1(i))) ^ 2)) + ...
            (vpa(d) * ((x - vpa(x1(i))) ^ 3))
        vals = x1(i):0.01:x1(i+1);
        x = vals;
        plot(vals, subs(f));
        hold on;
    end
end
end

function H = h_matrix(x)
n = length(x);
H = zeros(n,n);
H(1,1) = 1;
H(n,n) = 1;
for i = 2:n-1
    for j = 1:n
        if j == i
            H(i, j) = double(2 * ((x(i) - x(i - 1)) + (x(i + 1) - x(i))));
            H(i, j - 1) = double(x(i) - x(i - 1));
            H(i, j + 1) = double(x(i + 1) - x(i));
        end
    end
end
end

function C = k_matrix(x, y)
m = length(x);
n = length(y);
if m ~= n
    error("Error: x and y have different dimensions.");
else
    K = zeros(m,1);
    for i = 2:m-1
        h1 = double(x(i + 1) - x(i));
        h0 = double(x(i) - x(i - 1));
        a2 = double(y(i + 1));
        a1 = double(y(i));
        a0 = double(y(i - 1));
        K(i,1) = double(((3 * (a2 - a1)) / h1) - ((3 * (a1 - a0)) / h0)); 
    end
    H = h_matrix(x);
    C = H\K;
end
end

function [A, B, C, D] = spline_coeff(x, y)
m = length(x);
n = length(y);
if m ~= n
    error('Error: x and y have different dimensions.');
else
    B = zeros(length(y)-1,1);
    D = B;
    C = k_matrix(x,y);
    A = y;
    for i = 1:m-1
        h = (x(i + 1) - x(i));
        B(i,1) = double(((A(i + 1) - A(i)) / h) - (((C(i + 1) + 2 * C(i)) * h) / 3));
        D(i,1) = double((C(i + 1) - C(i)) / (3 * h));
    end
end
end

function x_root = bisection(f, x1, y1, x2, y2, error_tol)
root = 1;
if x1 > x2 
    error('Error: x1 > x2.');
elseif ((y1 > 0) && (y2 > 0)) || ((y1 < 0) && (y2 < 0))
    error('Error: y1 and y2 have the same sign.');
else
    while abs(root) > error_tol
        x_root = (x2 + x1)/2;
        x = x_root;
        root = double(subs(f));
        if (y1 > 0) && (root >= 0)
            x1 = x;
        elseif (y1 < 0) && (root <= 0)
            x1 = x;
        else
            x2 = x;
        end
    end
end
end