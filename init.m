function [n, U, L, k, step, eta, c, f_best_QIBAS, u_best_QIBAS, ...
          F_Best_QIBAS, U_Best_QIBAS]= init(l)

n= 1;                 % Iterations
U = 0;
L = 0;

% Intialize the QIBAS parameters
k = length(l) + 1; % Dimension 
step= 10;               % Step 
eta = 1;                % Step controlling factor
c = 5;                  % Antenna controlling factor

f_best_QIBAS = [];      % List Best Objective function values
u_best_QIBAS = [];      % List Best Optimizing variables

F_Best_QIBAS = [];
U_Best_QIBAS = [];

end