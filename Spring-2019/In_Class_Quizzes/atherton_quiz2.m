syms T
u = 0.6 * exp(-0.008 * T); % [g/cm-s]
R = 3; % [cm]
deltaP = 70; % [g/cm-s^2]
L = 10; % [cm]
density = 2; % [g/cm^3]
velocity = deltaP * R^2 / (4 * u * L); % [cm/s]
Re = density * velocity * L / u - 2300; % [-]
ezplot(Re,[0,100])
[x_root, i] = newton_raphson(Re,0,0.001)

function [x_root, i] = newton_raphson(f, x1, error_tol)
    T      = x1;
    zero   = double(subs(f));                                  % sets zero to the value of the 
                                                                   % function at the given x 
                                                                   % point
    x_root = x1;                                               % renames input x value
    i      = 0;                                                % sets iteration counter to zero 
    while abs(zero) > error_tol                                % checks to see if another 
                                                                   % iteration should be 
                                                                   % performed
        T     = x_root;
        slope = double(subs(diff(f)));                         % finds the slope of the function 
                                                                   % at the given point
        if slope == 0                                          % checks for a minimum or maximum
            fprintf('Error: stuck at minimum or maximum of function.')
            zero   = 0;                                        % breaks the while loop so that the 
                                                                   % function doesn't go on forever
            x_root = 'N/A'; 
        else
            b      = zero - slope * x_root;                    % finds the b of the function 
                                                                   % y = mx + b
            x_root = double(-b / slope);                       % finds the new x where y = 0 for 
                                                                   % the linear function
            T      = x_root;
            zero   = double(subs(f));                          % finds the value of the function 
                                                                   % at the x found above
            i      = i + 1;                                    % adds iteration to counter
        end
    end
    if x_root == 'N/A'                                         % changes the zero value to N/A in 
                                                                   % the case that a maximum was 
                                                                   % found after loop break
        zero  = 'N/A';
    end
end
