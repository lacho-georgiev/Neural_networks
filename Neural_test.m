clear
variables_best01;

w1 = rand(M, N);
b1 = rand(M, 1);
w2 = rand(K, M);
b2 = rand(K, 1);

training_data_plus_minus_25;
ceca = zeros(n, 1);
for t = 1: n
    if mod(t, n/100) == 0
        fl = t/n*100
    end
    avg_w1 = zeros(M, N);
    avg_b1 = zeros(M, 1);
    avg_w2 = zeros(K, M);
    avg_b2 = zeros(K, 1);
    for batch = 1 : m
        idx = randi(n_ex);
        a0 = ex{idx};
        y = an{idx};
        z1 = w1 * a0 + b1;
        a1 = sigma1(z1);
        z2 = w2 * a1 + b2;
        a2 = sigma1(z2);

        dC_dw2 = sum(a1.*(sigma1_deriv(z2).*2.*(a2-y))')';
        dC_da2 = 2*(a2 - y);
        dC_db2 = sigma1_deriv(z2).*2.*(a2-y);
        dC_da1 = zeros(M, 1);
        dC_da1_K = repmat(dC_da1, 1 , K)'; 
        dC_da1_K = dC_da1_K + (w2.*sigma1_deriv(z2).*dC_da2);
        dC_da1 = sum(dC_da1_K)';
        dC_dw1 = (a0.*(sigma1_deriv(z1)'.*dC_da1'))';
        dC_db1 = sigma1_deriv(z1).*dC_da1;
        Y = 0.1;
        w1 = w1 - Y * dC_dw1;
        w2 = w2 - Y * dC_dw2;
        b1 = b1 - Y * dC_db1;
        b2 = b2 - Y * dC_db2;
        avg_w1 = avg_w1 + w1;
        avg_b1 = avg_b1 + b1;
        avg_w2 = avg_w2 + w2;
        avg_b2 = avg_b2 + b2;
    end
    c = sum ((a2 - y).^2);
    ceca(t) = c;
    w1 = avg_w1 ./ m;
    b1 = avg_b1 ./ m;
    w2 = avg_w2 ./ m;
    b2 = avg_b2 ./ m;
end
plot(ceca)
ylim([0, 1])
