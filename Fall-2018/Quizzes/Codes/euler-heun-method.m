%Euler Method
clc
clear


xo = 1; %Initial x point chosen
fo = 12; %Initial f(x) value
dx = 2; %Step Size
xfinal = 5; %Final x point for interval
xf = xfinal - dx; %Used for setting up end point in loop for x interval
finalfx = [fo]; %Array of f(x) values
i = 2; %Index for array of f(x) values
xvals = [xo]; %x value array

for x = xo:dx:xf %Find f(x) values at each stepping point until final point
    fpx = x^2; %f'(x) value at specified point
    fxdx = fo + fpx*dx; %f(xi+dx) = f(xi) + f'(xi)*dx
    fo = fxdx;  %Creates new f(x) to start from to find next point
    finalfx(i) = fxdx; %Adds found f(x) point to array of f(x) values
    j = x + dx;
    xvals(i) = j; %Add x values to array
    i = i + 1; %Increases index array to next point
end

arrayxvalues = xvals
arrayfxvalues = finalfx
figure
plot(xvals, finalfx, 'o')


%{
%Heun Method

xo = 1; %Initial x point chosen
fo = 12; %Initial f(x) value
dx = 1; %Step Size
xfinal = 5; %Final x point for interval
xf = xfinal - dx; %Used for setting up x interval in loop
finalfx = [fo]; %Array of f(x) values
i = 2; %Index for array of f(x) values
xvals = [xo]; %Array for x values

for x = xo:dx:xf %Find f(x) value at each stepping point until final point
    fpx1 = x^2; %f'(x) value at specified point
    fpx2 = (x+dx)^2; %f'(x) for other line
    fxdx = fo + (1/2)*(fpx1+fpx2)*dx; %f(xi+dx) = f(xi)+(1/2)*(f'1+f'2)*dx
    fo = fxdx;  %Creates new f(x) to start from to find next point
    finalfx(i) = fxdx; %Adds found f(x) point to array of f(x) values
    j = x + dx;
    xvals(i) = j;
    i = i + 1; %Increases index array to next point
end

arrayfinalxvalues = xvals
arrayfinalfxvalues = finalfx
figure
plot(xvals, finalfx, 'o')
%}

%{
%ODE

xo = 0; %Initial x point chosen
fpo = 0; %Initial f'(x) value
fo = 0; %Initial f(x) value
dx = 1; %Step Size
xfinal = 5; %Final x point for interval
xf = xfinal - dx; %This just makes setting boundary x easier in loop
finalfpx = [fpo]; %Array of f'(x) values
finalfx = [fo]; %array of f(x) values
i = 2; %Index for array of f'(x) values
xvals = [xo]; %x value array

for x = xo:dx:xf %Find f''(x) values at each stepping point until final point
    fppx = 2; %f''(x) value at specified point
    fpxdx = fpo + fppx*dx; %f'(xi+dx) = f'(xi) + f''(xi)*dx
    fpo = fpxdx;  %Creates new f'(x) to start from to find next point
    finalfpx(i) = fpxdx; %Adds found f'(x) point to array of f'(x) values
    j = x + dx; %x value at next point for f'(x)
    xvals(i) = j; %Add x values to f'(x) array
    i = i + 1; %Increases index array to next point
end
arrayfinalxvals = xvals
arrayfinalfpx = finalfpx
figure
plot(xvals, finalfpx, 'o')
hold on

h = 2; %Sets up index in array for f(x2) in loop
k = 1; %Index value to set up f'(x1) for first iteration in loop
for x = xo:dx:xf %Find f(x) values at each stepping point until final point
    fpx = finalfpx(k); %f'(x) value at specified point
    k = k + 1; %Index value for f'(x) array for next loop
    fxdx = fo + fpx*dx; %f(xi+dx) = f(xi) + f'(xi)*dx
    fo = fxdx;  %Creates new f(x) to start from to find next point
    finalfx(h) = fxdx; %Adds found f(x) point to array of f(x) values
    h = h + 1; %Indexes f(x)array to next point for next loop
end

arrayfinalfx = finalfx
plot(xvals, finalfx, 'x')
%}


