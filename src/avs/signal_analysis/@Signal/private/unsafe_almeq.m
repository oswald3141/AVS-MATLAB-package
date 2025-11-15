function r = unsafe_almeq(a, b)

REALMAX = (2-2^(-52))*2^1023; % realmax
REALMIN = 2^(-1022); % realmin
EPSx128 = 2^-45; % 128*eps()

abs_th = REALMIN;
epsilon = EPSx128;
diff = abs(a - b);
norm = min(abs(a+b), REALMAX);
r = diff < max(abs_th, epsilon*norm);

end
