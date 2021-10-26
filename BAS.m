% Clear and close everything
clc
close all

% Load the data 
data = readtable('data/df_train_2002.csv');
num_of_labels = 28;                     % Total labels are 42 [28, 14]
labels = 3:num_of_labels+2;             % Indices for the labels
class = 2;                              % Index for the class
data = table2array(data(2:end, [class, labels]));
thresh = 0.05;

% Simulation parameters
trials = 1;             % Trials
n= 0;                 % Iterations
U = 0;
L = 0;

% Intialize the QBAS parameters
k = length(labels) + 1; % Dimension 
step= 1;                % Step 
d = 1;                  % Step controlling factor

% Intialize the problem parameters
u = rand(1, k);                     % Optimizing variables
ubest = u;                          % Best Optimizing variables
F = @(u)obj_func(u, data, thresh, 'linear');          % Objective function handle
fbest = F(ubest);                   % Best Objective function value

f_best_BAS = [];               % List Best Objective function values
u_best_BAS = [];               % List Best Optimizing variables

U_best_BAS = [];
F_best_BAS = [];
% Aalgorithm test parameters
total_test = 200;
tic

for j=1:trials
    step= 1;                % Step 
    d = 1;                  % Step controlling factor

    % Intialize the problem parameters
    u = rand(1, k);                     % Optimizing variables
    ubest = u;                          % Best Optimizing variables
    F = @(u)obj_func(u, data, thresh, 'linear');          % Objective function handle
    fbest = F(ubest);                   % Best Objective function value

    f_best_BAS = [];               % List Best Objective function values
    u_best_BAS = [];               % List Best Optimizing variables
    for i=1:n 
        b = rand(1, k);

        u_r = u + d*b;
        u_l = u - d*b;

        p = step*b.*sign(F(u_r) - F(u_l));

        u = u - p;
        fnc = F(u);

        if fnc < fbest
            ubest = u;
            fbest = fnc;
        end
        f_best_BAS = [f_best_BAS; fbest];
        u_best_BAS = [u_best_BAS; ubest];

        d = 0.95*d + 0.01;
        step = step*0.95;
        
        loss = F(ubest);
        U = U + ubest;
        L = L + loss;
    end
    
            
    F_best_BAS = [F_best_BAS, f_best_BAS];
    U_best_BAS = [U_best_BAS; ubest];
    u_best_BAS = [];
    f_best_BAS = [];
end

U_best = sum(U_best_BAS, 1)/trials;
% Load Test data 
data = readtable('data/df_test_2003.csv');
% Aalgorithm test parameters
total_test = 4916;

labels = 3:num_of_labels+2;             % Indices for the labels
class = 2;                              % Index for the class
data = table2array(data(2:end, [class, labels]));


test_data = data(1:total_test, :);
[correct, wrong, real, pred, accuracy, sensitivity, precision, ndcg,...
    loss] = evaluate_func(U_best, test_data, thresh);
for i=1:length(real)
    disp(['real: ', num2str(real(i)), ' predict: ', num2str(pred(i))])
end
fprintf(['Total Tested: ', num2str(total_test), ' Correct: ',...
    num2str(correct), ' Wrong: ', num2str(wrong), ' accuracy: ',num2str(accuracy),...
    ' sensitvity: ', num2str(sensitivity),...
    ' precision: ', num2str(precision), ' ndcg: ', num2str(ndcg),...
    ' Loss: ', num2str(loss), '\n'])

U = U/trials;
L = L/trials;
toc


