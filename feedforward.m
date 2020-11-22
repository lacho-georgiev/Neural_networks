function aL = feedforward(a1, b, w, L)
    a = a1;
    for l = 2 : L
       z = w{l}*a + b{l};
       a = sigmoid(z); 
    end
    aL = a;
end