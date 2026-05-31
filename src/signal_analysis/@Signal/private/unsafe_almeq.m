function r = unsafe_almeq(a, b)
% UNSAFE_ALMEQ Calc almeq for double without any checks (for speed)

diff = abs(a - b);
norm = min(abs(a+b), (2-2^(-52))*2^1023); % realmax
r = diff < max(2^(-1022), norm*2^-45); % realmin, 128*eps()
end
