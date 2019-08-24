%Euler Method
clc
clear

%{
xo = 0; %Initial x point chosen
fo = 150; %Initial f(x) value
dx = .5; %Step Size
xfinal = 7; %Final x point for interval
xf = xfinal - dx; %Used for setting up end point in loop for x interval
finalfx = [fo]; %Array of f(x) values
i = 2; %Index for array of f(x) values
xvals = [xo]; %x value array
finalfpx = [];
l = 1;

for x = xo:dx:xf %Find f(x) values at each stepping point until final point
    fpx = (-0.005*fo^2-(5.0*fo)/(0.123+fo)); %f'(x) value at specified point
    finalfpx(l) = fpx;
    l = l+1;
    fxdx = fo + fpx*dx; %f(xi+dx) = f(xi) + f'(xi)*dx
    fo = fxdx;  %Creates new f(x) to start from to find next point
    finalfx(i) = fxdx; %Adds found f(x) point to array of f(x) values
    j = x + dx;
    xvals(i) = j; %Add x values to array
    i = i + 1; %Increases index array to next point
end


arrayxvalues = xvals
arrayfinalfpx = finalfpx
arrayfxvalues = finalfx
figure
plot(xvals, finalfx, 'o')
%}

%Euler Method decomposition predictions

fpo = 3900; %Initial guess of f'(x)
error = 2; %Just an error greater than specified error to get loop going
boundaryvalue = 300

while error > .01
xo = 0; %Initial x point chosen
fo = 500; %Initial f(x) value
fpo = fpo - 1;
go = fpo; %Redefine equation for g(x) = f'(x)
dx = 0.01; %Step Size
xfinal = 0.1; %Final x point for interval
xf = xfinal - dx; %Used for setting up end point in loop for x interval
finalfx = [fo]; %Array of f(x) values
i = 2; %Index for array of f(x) values
xvals = [xo]; %x value array
finalgx = [go];
finalgpx = [];
k = 1;

for x = xo:dx:xf %Find f(x) values at each stepping point until final point
    fxdx = fo + go*dx; %Find f(x) value at next point
    finalfx(i) = fxdx; %Add next f(x) value to array
    fo = fxdx; %Creates new f(x) to start from to find next point
    gpx = 400*(fo-300); %f'(x) value at specified point
    gxdx = go + gpx*dx; %Find next g(x) = f'(x) value
    finalgx(i) = gxdx;
    finalgpx(k) = gpx;
    go = gxdx;
    j = x + dx;
    xvals(i) = j; %Add x values to array
    i = i + 1; %Increases index array to next point
    k = k + 1;
end

error = finalfx(i-1) - boundaryvalue;
end

fxdx = fo + go*dx;
fo = fxdx;
gpx = 400*(fo-300);
finalgpx(k) = gpx;

arrayxvalues = xvals
arrayfinalgpx = finalgpx
arrayfinalgx = finalgx
arrayfxvalues = finalfx
figure
plot(xvals, finalfx, 'o')
finalfpoguess = fpo
error = error;

%{
%Find a value of g(x) = f'(x) at x value in spleen
x2 = xvals;
y2 = finalfx;
xx2 = xo:0.01:xfinal; %spleen from xo, chosen spleen size, final x point
yy2 = spline(x2,y2,xx2);
plot(x2,y2,'o',xx2,yy2)

ChosenXval = 10; %User input for f(x) value you want at given input X
%Make sure to multiply/divide by spleen step size to get point at X value
%That you actually want.  Be aware of where spleen starts
%THIS IS LIKELY NOT THE ACTUAL X VALUE INPUT YOU WANT, YOU HAVE TO
%CALCULATE IT BY THINKING ABOUT START X AND HOW BIG STEP SIZE IS IN SPLEEN
YvalueSpleenAtChosenX = yy2(ChosenXval+1)
%}

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


%ODE
%{
xo = 1; %Initial x point chosen
fpo = 3; %Initial f'(x) value
fo = 6; %Initial f(x) value
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

%{
xo = 1; %Initial x point chosen
fpo = 3; %Initial f'(x) value at initial x
fo = 6; %Initial f(x) value at initial x
go = fpo; %Initial g(x) = f'(x)redefined function
dx = 1; %Step Size
xfinal = 5; %Final x point for interval
xf = xfinal - dx; %This just makes setting boundary x easier in loop
finalfx = [fo]; %array of f(x) values
finalgx = [fpo]; %array of g(x) = f'(x) value
finalgpx = [];
i = 2; %Index for array of f'(x) values
h = 2; %Sets up index in array for f(x2) in loop
k = 1;
xvals = [xo]; %x value array

for x = xo:dx:xf %Find f''(x) values at each stepping point until final point
    gpx = 5*go-3*fo+x^3; %g'(x)=f''(x) redefined equation at specified point
    finalgpx(k) = gpx; %Array of g'(x) = f''(x) values
    gxdx = go + gpx*dx; %g(x+dx) = g(x)+g'(x)*dx = f'(xi) + f''(xi)*dx
    go = gxdx;  %Creates new g(x) = f'(x) to start from to find next point
    finalgx(i) = go; %Adds found g(x) = f'(x) point to array of f'(x) values
    gx = finalgx(k); %g(x) = f'(x) value at iteration point reset for f(x)
    fxdx = fo + gx*dx; %f(xi+dx) = f(xi) + f'(xi)*dx
    fo = fxdx;  %Creates new f(x) to start from to find next point
    finalfx(h) = fxdx; %Adds found f(x) point to array of f(x) values
    h = h + 1; %Indexes f(x)array to next point for next loop
    k = k + 1; %Indexes g(x) array
    j = x + dx; %x value at next point for g(x)=f'(x)
    xvals(i) = j; %Add x values to f'(x) array
    i = i + 1; %Increases index array to next point
end

x = x + dx; %One more iteration just to show g'(x) = f''(x) value at last point
gpx = 5*go-3*fo+x^3; %g'(x)=f''(x) value at end point
finalgpx(k) = gpx; %Adds found g'(x) = f''(x) point to array of  values

arrayfinalxvals = xvals
arrayfinalgpx = finalgpx
arrayfinalgx = finalgx
arrayfinalfx = finalfx
figure
plot(xvals, finalgpx, 'P')
hold on;
plot(xvals, finalgx, 'o')
hold on;
plot(xvals, finalfx, 'x')
%}
%{
%Find a value of g'(x) = f''(x) at x value in spleen
x1 = xvals;
y1 = finalgpx;
xx1 = xo:0.01:xfinal; %spleen from xo, chosen spleen size, final x point
yy1 = spline(x1,y1,xx1);
plot(x1,y1,'m',xx1,yy1)

ChosenXval = 200; %User input for f(x) value you want at given input X
%Make sure to multiply/divide by spleen step size to get point at X value
%That you actually want.  Be aware of where spleen starts
%THIS IS LIKELY NOT THE ACTUAL X VALUE INPUT YOU WANT, YOU HAVE TO
%CALCULATE IT BY THINKING ABOUT START X AND HOW BIG STEP SIZE IS IN SPLEEN
YppxValueSpleenAtChosenX = yy1(ChosenXval+1)


%Find a value of g(x) = f'(x) at x value in spleen
x2 = xvals;
y2 = finalgx;
xx2 = xo:0.01:xfinal; %spleen from xo, chosen spleen size, final x point
yy2 = spline(x2,y2,xx2);
plot(x2,y2,'o',xx2,yy2)

ChosenXval = 300; %User input for f(x) value you want at given input X
%Make sure to multiply/divide by spleen step size to get point at X value
%That you actually want.  Be aware of where spleen starts
%THIS IS LIKELY NOT THE ACTUAL X VALUE INPUT YOU WANT, YOU HAVE TO
%CALCULATE IT BY THINKING ABOUT START X AND HOW BIG STEP SIZE IS IN SPLEEN
YvalueSpleenAtChosenX = yy2(ChosenXval+1)


%Find a value of f(x) at chosen x value in spleen
x3 = xvals;
y3 = finalfx;
xx3 = xo:0.01:xfinal; %spleen from xo, chosen spleen size, final x point
yy3 = spline(x3,y3,xx3);
plot(x3,y3,'x',xx3,yy3)

ChosenXval3 = 300; %User input for f(x) value you want at given input X
%Make sure to multiply/divide by spleen step size to get point at X value
%That you actually want.  Be aware of where spleen starts
%THIS IS LIKELY NOT THE ACTUAL X VALUE INPUT YOU WANT, YOU HAVE TO
%CALCULATE IT BY THINKING ABOUT START X AND HOW BIG STEP SIZE IS IN SPLEEN
YxValueSpleenAtChosenX = yy3(ChosenXval3+1)
%}