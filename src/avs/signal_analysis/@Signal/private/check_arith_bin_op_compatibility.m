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

end
