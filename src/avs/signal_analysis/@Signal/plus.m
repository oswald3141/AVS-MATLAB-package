function a = plus(a, b)
% PLUS Adds signal to another signal or a numeric value
%
%   A = PLUS(A, B) adds A to B if one of them is Signal and the
%   other one is either Signal or a numeric value. Performs dimensions
%   expansion if necessary.

arguments
    a 
    b {mustHaveCompatibleSizes(a, b)}
end

aIsSig = isa(a, "Signal");
bIsSig = isa(b, "Signal");
aIsNum = isnumeric(a);
bIsNum = isnumeric(b);

if aIsSig && bIsSig
    a = bsxfun_arith(@plus_sig_sig, a, b);
elseif aIsSig && bIsNum
    a = bsxfun_arith(@plus_sig_num, a, b);
elseif bIsSig && aIsNum
    b = bsxfun_arith(@plus_sig_num, b, a);
    a = b;
else
    throw(MException( ...
        "Signal:plus:mustBeNumericOrSignal", ...
        "Value must be numeric or Signal."))
end

end
