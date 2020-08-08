function a2 = naural_run(a0, w1, w2, b1, b2)
    z1 = w1 * a0 + b1;
    a1 = sigma1(z1);
    z2 = w2 * a1 + b2;
    a2 = sigma1(z2);
end