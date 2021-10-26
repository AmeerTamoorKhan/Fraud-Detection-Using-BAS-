% Clear and close everything
clc
close all

% Load the data 
data = readtable('data/df_train_2003.csv');
num_of_labels = 28;                     % Total labels are 42 [28, 14]
labels = 3:num_of_labels+2;             % Indices for the labels
class = 2;                              % Index for the class
data = table2array(data(2:end, [class, labels]));
%thresh = 0;
thresh = 0.1;

% Simulation parameters
trials = 1;             % Trials
n= 100;                 % Iterations
U = 0;
L = 0;

% Intialize the QIBAS parameters
k = length(labels) + 1; % Dimension 
step= 10;               % Step 
eta = 1;                % Step controlling factor
c = 5;                  % Antenna controlling factor


% Intialize the problem parameters
u = rand(1, k);                        % Optimizing variables
ubest = u;                             % Best Optimizing variables
F = @(u)obj_func(u, data, thresh, 'linear');   % Objective function handle
fbest = F(ubest);                      % Best Objective function value

f_best_QIBAS = [];               % List Best Objective function values
u_best_QIBAS = [];               % List Best Optimizing variables

F_Best_QIBAS = [];
U_Best_QIBAS = [];

Pred_val = [];

tic
for k=1:1
    
    [n, U, L, k, step, eta, c, f_best_QIBAS, u_best_QIBAS, ...
          F_Best_QIBAS, U_Best_QIBAS] = init(labels);
      
%     for j=1:trials
%         step= 10;               % Step 
%         eta = 1;                % Step controlling factor
%         c = 5;                  % Antenna controlling factor
% 
%         % Intialize the problem parameters
%         u = rand(1, k);                                 % Optimizing variables
%         ubest = u;                                      % Best Optimizing variables
%         F = @(u)obj_func(u, data, thresh, 'linear');    % Objective function handle
%         fbest = F(ubest);                               % Best Objective function value
        for i = 1 : n
            d0 = step / c;
            dir = rand(1, k);
            dir = dir/(eps + norm(dir));
            uleft =u + dir * d0;
            fleft = F(uleft);
            uright = u-dir*d0;
            fright = F(uright); 
            u = u - step .* dir .* sign(fleft - fright);   
            newf = F(u);
            cz_u=eccz(uleft,uright,ubest, F);
            cz_f =F(cz_u);

            if cz_f < newf 
                u = cz_u;
                newf = cz_f;
            end
            if newf < fbest
                ubest = u;
                fbest = newf;
            end
            u_best_QIBAS = [u_best_QIBAS; ubest];
            f_best_QIBAS = [f_best_QIBAS; fbest];
            step = step * eta;
        end
        U_Best_QIBAS = ubest;
        
%         F_Best_QIBAS = [F_Best_QIBAS, f_best_QIBAS];
%         U_Best_QIBAS = [U_Best_QIBAS; ubest];
%         u_best_QIBAS = [];
%         f_best_QIBAS = [];
% 
%         loss = F(ubest);
%         U = U + ubest;
%         L = L + loss;
% 
%     end

U_best = sum(U_Best_QIBAS, 1)/trials;
% Load Test data 
data = readtable('data/df_test_2004.csv');
% Aalgorithm test parameters
total_test = 5000;

labels = 3:num_of_labels+2;             % Indices for the labels
class = 2;                              % Index for the class
data = table2array(data(2:end, [class, labels]));


test_data = data(1:total_test, :);
[correct, wrong, real, pred, accuracy, sensitivity, precision, ndcg,...
    loss, pred_val] = evaluate_func(U_best, test_data, thresh);
for i=1:length(real)
    disp(['real: ', num2str(real(i)), ' predict: ', num2str(pred(i))])
end
fprintf(['Total Tested: ', num2str(total_test), ' Correct: ',...
    num2str(correct), ' Wrong: ', num2str(wrong), ' accuracy: ',num2str(accuracy),...
    ' sensitvity: ', num2str(sensitivity),...
    ' precision: ', num2str(precision), ' ndcg: ', num2str(ndcg),...
    ' Loss: ', num2str(loss), '\n'])

% U = U/trials;
% L = L/trials;


Pred_val = [Pred_val; pred_val];

thresh = thresh + 0.1;
end
toc

function y=eccz(pl, pj, pg, F)
y=0.5*((pj.*pj-pg.*pg)*F(pl)+(pg.*pg-pl.*pl)*F(pj)+(pl.*pl-pj.*pj)*F(pg))./((pj-pg)*F(pl)+(pg-pl)*F(pj)+(pl-pj)*F(pg)+eps);
end


