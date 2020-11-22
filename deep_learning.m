clear
n = 180000;
m = 10;
eta = 3;

layers = [784, 30, 10];
L = length(layers);

a = cell(1, L);
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
a{1} = x;
for l = 2 : L
    a{l} = rand(layers(l), 1);
    b{l} = rand(layers(l), 1);
    w{l} = rand(layers(l), layers(l - 1));
    avg_w = zeros(layers(l), layers(l - 1));
    avg_b = zeros(layers(l), 1);
end

pl = zeros(n, 1);
for t = 1 : n
    if mod(t, n/100) == 0
        fl = t/n*100
    end
    for l = 2 : L
        nabla_b{l} = zeros(layers(l), 1);    
        nabla_w{l} = zeros(layers(l), layers(l - 1));   
	end
    
    for batch = 1 : m
        idx = randi(n_ex);
        x = ex{idx};
        y = an{idx}';

        [dnb, dnw] = backprop(x, y, b, w, L);
        for l = 2 : L
            nabla_b{l} = nabla_b{l} + dnb{l};
            nabla_w{l} = nabla_w{l} + dnw{l};
        end
    end
    for l = 2:L
        b{l} = b{l}-(eta/m)*nabla_b{l};
        w{l} = w{l}-(eta/m)*nabla_w{l};

%         z{l} = w{l}*a{l - 1} + b{l};
%         a{l} = sigmoid(z{l});
    end    
    pl(t) = sum((a{L} - y).^2)/2;
end
plot(pl)
% ylim([0, 1])

