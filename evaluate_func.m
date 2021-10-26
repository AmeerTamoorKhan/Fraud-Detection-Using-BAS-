function [correct, wrong, class, preds, accuracy, sensitivity_topk,...
    precision_topk, ndcg_at_k, loss, OBJ] = evaluate_func(u, data, thresh)
    w = u(1:end-1);
    b = u(end);
    class = data(:, 1);
    labels = data(:, 2:end);
    preds = zeros(size(class, 1), 1);
    Preds = zeros(size(class, 1), 1);
    OBJ = zeros(size(class, 1), 1);
    correct = 0;
    wrong = 0;
    TP = 0;
    FP = 0;
    
    TN = 0;
    FN = 0;
    for i=1:size(data, 1)
        obj_val = 1/(1 + exp(-w*labels(i, :)' + b));
        
        if obj_val >= thresh
            preds(i) = 1; 
            Preds(i) = 0.9;
        elseif obj_val <= thresh
            preds(i) = 0;
            Preds(i) = 0.1;
        end
        
        if abs(class(i)- preds(i)) < 0.01
            correct = correct + 1;
        else
            wrong = wrong + 1;
        end
        
        if (class(i) == 1) && (preds(i) == 1)
            TP = TP + 1;
        elseif (class(i) == 1) && (preds(i) == 0)
            FP = FP + 1;
        end
        
        if (class(i) == 0) && (preds(i) == 0)
            TN = TN + 1;
        elseif (class(i) == 0) && (preds(i) == 1)
            FN = FN + 1;
        end
        
        
        OBJ(i) = obj_val;
    end
    %sensitivity = TP/(TP + FP);
    %specificity = TN/(TN + FN);
    accuracy = (TP + TN)/(TP + TN + FP + FN);
    loss = -sum(class.*log(Preds) + (1 - class).*log(1 - Preds))/length(class);
    
     results = evaluate(class,preds,OBJ, 0.01);
     
     sensitivity_topk = results.sensitivity_topk*100;
     precision_topk = results.precision_topk*100;
     ndcg_at_k = results.ndcg_at_k;
     %accuracy = results.auc;

end