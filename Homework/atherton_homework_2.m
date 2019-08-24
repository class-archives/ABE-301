%% Homework 2
% Kathryn Atherton
% ABE 30100
% February 15, 2019
% Computations only, see pdf or hard copy for Part C

%% Part A
k1 = 7; % [min^-1]
vm = 0.1; % [mol/L-min]
km = 1; % [mol/L]
k3 = 0.02; % [L/mol-min]

syms Catp % [mol/L]
r1 = k1 * Catp; % [mol/L-min]
r2 = - (vm * Catp) / (km + Catp); % [mol/L-min]
r3 = -k3 * Catp ^ 2; % [mol/L-min]

roverall = r1 + r2 + r3;
ezplot(roverall, [0,500])
set(gca,'XGrid','on','YGrid','on')
title('Overall Rate of ATP Reaction vs. ATP Concentration')
ylabel('Rate of ATP Reaction [mol/L-min]')
xlabel('ATP Concentration [mol/L]')

%% Part B
error_tol = 0.0001;

x1 = 200; % for bisection and regula falsi
y1 = double(subs(roverall,Catp,x1)); % for bisection and regula falsi
x2 = 400; % for bisection and regula falsi
y2 = double(subs(roverall,Catp,x2)); % for bisection and regula falsi
x3 = 300; % for Newton-Raphson

colNames = {'Iteration', 'Catp', 'rCatp'};
bisection_method = bisection(roverall, x1, y1, x2, y2, error_tol);
Table_bisection = array2table(bisection_method, 'VariableNames', colNames)

false_position_method = regula_falsi(roverall, x1, y1, x2, y2, error_tol);
Table_false_position = array2table(false_position_method, 'VariableNames', colNames)

newton_raphson_method = newton_raphson(roverall, x3, error_tol);
Table_newton_raphson = array2table(newton_raphson_method, 'VariableNames', colNames)

%% Functions
function [matrix] = bisection(f, x1, y1, x2, y2, error_tol)
    % sets up the output matrix which will be formatted as a table later
    matrix = zeros(1,3);
    
    % sets zero to something greater than the error tolerance to start the
    % while loop
    zero = 1 + error_tol;
    
    % starts iteration counter
    i = 1;
    
    % checks that x1 < x2
    if x1 > x2                                                 
        fprintf('Error: x1 > x2.\n');
        zero = 'N/A';
        Catp = 'N/A';
    
    % checks that f(x1) and f(x2) are of opposite signs
    elseif ((y1 > 0) && (y2 > 0)) || ((y1 < 0) && (y2 < 0))    
        fprintf('Error: y1 and y2 have the same sign.\n');
        zero = 'N/A';
        Catp = 'N/A';
    else
        % checks to see if another iteration should be performed
        while abs(zero) > error_tol
            % finds midpoint between x values
            Catp = (x2 + x1)/2;  
            
            % finds the y value of the midpoint
            zero = double(subs(f));
            
            % replaces the x value of the same sign as the midpoint of the 
            % x values with the midpoint
            if (y1 > 0) && (zero >= 0)                         
                x1 = Catp;
            elseif (y1 < 0) && (zero <= 0)
                x1 = Catp;
            else
                x2 = Catp;
            end
            
            % stores values in table to be output
            matrix(i, 1) = i;
            matrix(i, 2) = Catp;
            matrix(i, 3) = zero;
            
            % adds iteration to counter
            i = i + 1;                                         
        end
    end
end

function [matrix] = newton_raphson(f, x1, error_tol)
    % sets up the output matrix which will be formatted as a table later
    matrix = zeros(1,3);
    
    % sets zero to the value of the function at the given x point
    Catp = x1;
    zero = double(subs(f));
    
    % starts iteration counter 
    i = 1;   
    
    % checks to see if another iteration should be performed
    while abs(zero) > error_tol 
        % finds the slope of the function at the given point
        slope = double(subs(diff(f)));                         
        
        % checks for a minimum or maximum
        if slope == 0                                          
            fprintf('Error: stuck at minimum or maximum of function.\n')
            
            % breaks the while loop so that the function doesn't go on 
            % forever
            zero = 0;                                          
            Catp = 'N/A'; 
        else
            % finds the b of the function y = mx + b
            b = zero - slope * Catp;
            
            % finds the new x where y = 0 for the linear function
            Catp = double(-b / slope);   
            
            % finds the value of the function at the x found above
            zero = double(subs(f));
            
            % stores values in table to be output
            matrix(i, 1) = i;
            matrix(i, 2) = Catp;
            matrix(i, 3) = zero;
            
            % adds iteration to counter
            i = i + 1;
        end
    end
    
    % changes the zero value to N/A in the case that a maximum was found 
    % after loop break
    if Catp == 'N/A'                                           
        zero  = 'N/A';
    end
end


function [matrix] = regula_falsi(f, x1, y1, x2, y2, error_tol)
    % sets up the output matrix which will be formatted as a table later
    matrix = zeros(1,3);
    
    % sets zero to something greater than the error tolerance
    zero = 1 + error_tol;
    
    % starts iteration counter
    i = 1;   
    % checks that x1 < x2
    if x1 > x2                                                 
        fprintf('Error: x1 > x2.\n');
        zero = 'N/A';
        Catp = 'N/A';
    
    % checks that y1 and y2 are of different signs
    elseif ((y1 > 0) && (y2 > 0)) || ((y1 < 0) && (y2 < 0))    
        fprintf('Error: y1 and y2 have the same sign.\n');
        zero = 'N/A';
        Catp = 'N/A';
    else
        % checks to see if another iteration should be performed
        while abs(zero) > error_tol
            % calculates slope from y and x values
            slope  = (y2 - y1)/(x2 - x1);
            
            % calculates b from y = mx + b formula
            b = y2 - slope * x2;  
            
            % calculates new x from y = mx + b
            Catp = -b / slope;
            
            % calculates new root from function at x calculated
            zero = double(subs(f));  
            
            % replaces the x value of the same sign as the midpoint of the 
            % x values with the midpoint
            if (y1 > 0) && (zero >= 0)                         
                x1 = Catp;
            elseif (y1 < 0) && (zero <= 0)
                x1 = Catp;
            else
                x2 = Catp;
            end
            
            % stores values in table to be output
            matrix(i, 1) = i;
            matrix(i, 2) = Catp;
            matrix(i, 3) = zero;
            
            % adds to the iteration counter
            i = i + 1;                                    
        end
    end
end