w1 = rand(6, 25);
b1 = rand(6, 1);
w2 = rand(2, 6);
b2 = rand(2, 1);
training_data;
n = 10000;
m = 6;
ceca = zeros(n, 1);
for q = 1: n
    avg_w1 = zeros(6, 25);
    avg_b1 = zeros(6, 1);
    avg_w2 = zeros(2, 6);
    avg_b2 = zeros(2, 1);
    for p = 1 : m
        idx = randi(16);
        a0 = ex{idx};
        y = an{idx};
        z1 = w1 * a0 + b1;
        a1 = sigma1(z1);
        z2 = w2 * a1 + b2;
        a2 = sigma1(z2);

        dC_dw2 = sum(a1*(sigma1_deriv(z2).*2.*(a2-y))')';
        dC_da2 = 2*(a2 - y);
        dC_db2 = sigma1_deriv(z2).*2.*(a2-y);
        dC_da1 = zeros(6, 1);
        for j = 1:2
           dC_da1 = dC_da1 + (w2(j, :).*sigma1_deriv(z2(j)).*dC_da2(j))';
        end
        dC_dw1 = zeros(6, 25);
        for k = 1:25
            for j = 1:6
                dC_dw1(j, k) = a0(k)*sigma1_deriv(z1(j))*dC_da1(j);
            end
        end
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
    ceca(q) = c;
    w1 = avg_w1 ./ m;
    b1 = avg_b1 ./ m;
    w2 = avg_w2 ./ m;
    b2 = avg_b2 ./ m;
end
plot(ceca)
ylim([0, 1])
%naural_run(a0, w1, w2, b1, b2);
