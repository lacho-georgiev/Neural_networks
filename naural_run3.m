function a3 = naural_run3(a0, w1, w2, b1, b2, w3, b3)
    z1 = w1 * a0 + b1;
    a1 = sigma1(z1);
    z2 = w2 * a1 + b2;
    a2 = sigma1(z2);
    z3 = w3 * a2 + b3;
    a3 = sigma1(z3);
end