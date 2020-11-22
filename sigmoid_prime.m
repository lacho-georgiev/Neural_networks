function s = sigmoid_prime(z)
    s = sigmoid(z).*(1-sigmoid(z));
end