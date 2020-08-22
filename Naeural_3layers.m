variables_best01;

w1 = rand(M, N);
b1 = rand(M, 1);
w2 = rand(M2, M);
b2 = rand(M2, 1);
w3 = rand(K, M2);
b3 = rand(K, 1);

training_data;
ceca = zeros(n, 1);
for t = 1: n
    if mod(t, n/100) == 0
        fl = t/n*100
    end
    avg_w1 = zeros(M, N);
    avg_b1 = zeros(M, 1);
    
    avg_w2 = zeros(M2, M);
    avg_b2 = zeros(M2, 1);
    
    avg_w3 = zeros(K, M2);
    avg_b3 = zeros(K, 1);
    for batch = 1 : m
        idx = randi(n_ex);
        a0 = ex{idx};
        y = an{idx}';
        z1 = w1 * a0 + b1;
        a1 = sigma1(z1);
        
        z2 = w2 * a1 + b2;
        a2 = sigma1(z2);
        
        z3 = w3 * a2 + b3;
        a3 = sigma1(z3);

        dC_dw3 = sum(a2.*(sigma1_deriv(z3).*2.*(a3-y))')';
        dC_da3 = 2*(a3 - y);
        dC_db3 = sigma1_deriv(z3).*2.*(a3-y);
        
        dC_da2 = zeros(M2, 1);
        dC_da2_K = repmat(dC_da2, 1 , K)'; 
        dC_da2_K = dC_da2_K + (w3.*sigma1_deriv(z3).*dC_da3);
        dC_da2 = sum(dC_da2_K)';
        
        dC_dw2 = (a1.*(sigma1_deriv(z2)'.*dC_da2'))';
        dC_db2 = sigma1_deriv(z2).*dC_da2;
        
        
        dC_da1 = zeros(M, 1);
        dC_da1_K = repmat(dC_da1, 1 , M2)'; 
        dC_da1_K = dC_da1_K + (w2.*sigma1_deriv(z2).*dC_da2);
        dC_da1 = sum(dC_da1_K)';
        
        dC_dw1 = (a0.*(sigma1_deriv(z1)'.*dC_da1'))';
        dC_db1 = sigma1_deriv(z1).*dC_da1;
       
        w1 = w1 - Y * dC_dw1;
        w2 = w2 - Y * dC_dw2;
        w3 = w3 - Y * dC_dw3;
        b1 = b1 - Y * dC_db1;
        b2 = b2 - Y * dC_db2;
        b3 = b3 - Y * dC_db3;
        avg_w1 = avg_w1 + w1;
        avg_b1 = avg_b1 + b1;
        avg_w2 = avg_w2 + w2;
        avg_b2 = avg_b2 + b2;
        avg_w3 = avg_w3 + w3;
        avg_b3 = avg_b3 + b3;
    end
    c = sum ((a3 - y).^2);
    ceca(t) = c;
    w1 = avg_w1 ./ m;
    b1 = avg_b1 ./ m;
    w2 = avg_w2 ./ m;
    b2 = avg_b2 ./ m;
    w3 = avg_w3 ./ m;
    b3 = avg_b3 ./ m;
end
plot(ceca)
ylim([0, 1])