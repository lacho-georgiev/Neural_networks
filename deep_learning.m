clear
epochs = 20;
m = 10;
eta = 3;

layers = [784, 30, 10];
L = length(layers);

b = cell(1, L);
z = cell(1, L);
w = cell(1, L);
delta = cell(1, L);
nabla_b = cell(1, L);
nabla_w = cell(1, L);
avg_w = cell(1, L);
avg_b = cell(1, L);
x = rand(layers(1), 1);
y = rand(layers(L), 1);
training_data;

% INPUT
for l = 2 : L
    b{l} = randn(layers(l), 1);
    w{l} = randn(layers(l), layers(l - 1));
    avg_w = zeros(layers(l), layers(l - 1));
    avg_b = zeros(layers(l), 1);
end

pl = zeros(epochs, 1);
for t = 1 : epochs
    perm_indx = randperm(length(ex));
    ex = ex(perm_indx);
    an = an(perm_indx);
    for batch = 1 : length(ex)/m
        for l = 2 : L
            nabla_b{l} = zeros(layers(l), 1);    
            nabla_w{l} = zeros(layers(l), layers(l - 1));   
        end
        for mini_batch = (batch - 1) * m + 1 : batch * m
            x = ex{mini_batch};
            y = an{mini_batch};

            [dnb, dnw] = backprop(x, y, b, w, L);
            for l = 2 : L
                nabla_b{l} = nabla_b{l} + dnb{l};
                nabla_w{l} = nabla_w{l} + dnw{l};
            end
        end
        for l = 2:L
            b{l} = b{l}-(eta/m)*nabla_b{l};
            w{l} = w{l}-(eta/m)*nabla_w{l};
        end
    end
    cost = calc_cost(ex, an, b, w, L);
    p = [t+ ": " + cost];
    disp(p);
end

%plot(pl)
% ylim([0, 1])

