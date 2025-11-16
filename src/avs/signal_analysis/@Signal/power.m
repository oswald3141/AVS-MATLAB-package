function a = power(a, b)
% POWER Raises signal into a given power
%
%   A = POWER(A, B) raises each sample of each element of A into a
%   corresponding power from B. B must be a numeric array. Performs
%   dimensions expansion if necessary.

arguments
    a 
    b {mustHaveCompatibleSizes(a, b)}
end

aIsSig = isa(a, "Signal");
bIsSig = isa(b, "Signal");
aIsNum = isnumeric(a);
bIsNum = isnumeric(b);

if aIsSig && bIsSig
    a = bsxfun_arith(@power_sig_sig, a, b);
elseif aIsSig && bIsNum
    a = bsxfun_arith(@power_sig_num, a, b);
elseif bIsSig && aIsNum
    b = bsxfun_arith(@power_sig_num, b, a);
    a = b;
else
    throw(MException( ...
        "Signal:power:mustBeNumericOrSignal", ...
        "Value must be numeric or Signal."))
end

end
