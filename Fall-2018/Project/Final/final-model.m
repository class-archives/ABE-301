M_player = 80; % kg
V_w = 0.6 * M_player; % kg, Assumption 12
V_wdehyd = V_wi - 0.05 * V_wi; % kg, Assumption 11

% water parameters
MWw = 18.01/1000; % kg/mol
hvw = 43345 * 1000; % J/mol
rhow = 1; % kg/L

tspan = [0:0.0167:90];
cT0 = T_ref;

[t,V] = ode45(@heat,tspan,cT0);
dV_outdt = V(:,1) * MWw/(hvw*rhow);
plot(t,dV_outdt);
xlabel('Time [min]');
ylabel('Sweat Rate [L/min]');
xlim([0 90]);
hold on;

n = length(dV_outdt);
i = 1;
min = n/90;
total = 0;
dehyd = 0;
while i <= n
    total = total + dV_outdt(i);
    time = i / min;
    if total > V_wdehyd && dehyd == 0
        time = round(time);
        fprintf('Player becomes dehydrated at %f minutes.\n', time);
        dehyd = 1;
    end
    %scatter(time,total,'red');
    i = i + 1;
end

fprintf('The total volume of sweat is %f L.\n',total);


function dydt = heat(t,V)
    h = 20; % W/m^2.K
    cp = 3470; % J/kg.K
    h_player = 1.8; % m
    w_player = h_player / 4; % m
    A = pi * w_player * h_player; % m^2
    M_player = 80; % kg
    rho_player = 985; % kg/m^3
    v_player = 6; % m/s
    Eatp = 70000 / 0.50718; % J/kg
    MWatp = 0.50718; % kg/mol
    Eatp = Eatp * MWatp; % J/mol
    H_rxn_atpsynth = 2880 * 1000; % J/mol glucose
    vg = -1; % from fundamental relationships
    vo = -6; % from fundamental relationships
    va = 36; % from fundamental relationships
    vc = 6; % from fundamental relationships
    vw = 6; % from fundamental relationships
    hvw = 43345 * 1000; % J/mol
    rho_air = 1.225; % kg/m^3
    H_air = 23 / (1000 * rho_air); % g water / m^3 dry air
    Qmet = (370 + (21.6 * M_player * (1-0.12))) * 4184 / 86400; 
    
    ATPcons = M_player * v_player^2 / (Eatp); % mol ATP
    
    % Mass Balance
    ATPrxn = ATPcons;
    O2rxn = ATPrxn * -1 * vo / va; 
    O2in = O2rxn;
    CO2rxn = ATPrxn * vc / va;
    CO2out = CO2rxn;
    Waterrxn = ATPrxn * vw / va;
    Glucoserxn = -1 * ATPrxn * vg / va;
    
    % Energy Balance
    q = H_rxn_atpsynth * Glucoserxn + 1/2 * ATPcons * Eatp;
    Qh = hvw * rho_air * H_air * A;
    
    T_air = 23; % degrees C
    
    T_player = V(1);
    
    dQdt = -1 * h * A * (T_player - T_air) + q * M_player / (rho_player^2 * cp) + Qmet + Qh;
    
    dydt = [dQdt];
end