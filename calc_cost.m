function cost = calc_cost(ex, an, b, w, L)
    cost = 0;
    for i = 1 : length(ex)
        out = feedforward(ex{i}, b, w, L);
        cost = cost + sum((an{i} - out).^2);
    end
    cost = cost / length(ex);
end