function check_arith_bin_op_compatibility(s1, s2)

n1 = s1.n;
n2 = s2.n;

if n1 ~= n2
    if n1 ~= 1 && n2 ~= 1
        throwAsCaller(MException( ...
            "Signal:arithmeticBinaryOpeation:mustBeCompatible", ...
            "Signals must have same length, but %1~=%2.", n1, n2));
    end
end

Fs1 = s1.Fs;
Fs2 = s2.Fs;

if ~unsafe_almeq(Fs1, Fs2)
    throwAsCaller(MException( ...
        "Signal:arithmeticBinaryOpeation:mustBeCompatible", ...
        "Signals must have same sample rate, but %f~=%f.", Fs1, Fs2));
end

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

end
