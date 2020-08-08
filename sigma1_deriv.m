function s1 = sigma1_deriv (x)
    s1 = exp(-x)./((1+exp(-x)).^2);
end