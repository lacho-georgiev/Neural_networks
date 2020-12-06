function [nabla_b, nabla_w] = backprop(x, y, b, w, L)
    nabla_b = cell(1, L);
    nabla_w = cell(1, L);
    a = cell(1, L);
    a{1} = x;
    
    % FORWARD
    for l = 2 : L
        z{l} = w{l}*a{l - 1} + b{l};
        a{l} = sigmoid(z{l});
    end

    % OUTPUT ERROR
    delta{L} = (a{L} - y) .* sigmoid_prime(z{L});

    % BACKPROPAGATE THE ERROR
    for l = L - 1 : -1 : 2
        delta{l} = (w{l+1}' * delta{l+1}) .* sigmoid_prime(z{l});
    end

    % OUTPUT
    for l = L : -1 : 2
        nabla_b{l} = delta{l};
        nabla_w{l} = delta{l} .* a{l-1}';
    end
    
end