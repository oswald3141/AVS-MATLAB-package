function a = minus(a, b)
% MINUS Subtracts a signal or a numeric value from a signal
%
%   A = MINUS(A, B) subtracts A from B if one of them is Signal and the
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
    a = bsxfun_arith(@minus_sig_sig, a, b);
elseif aIsSig && bIsNum
    a = bsxfun_arith(@minus_sig_num, a, b);
elseif bIsSig && aIsNum
    b = bsxfun_arith(@minus_sig_num, b, a);
    a = b;
else
    throw(MException( ...
        "Signal:minus:mustBeNumericOrSignal", ...
        "Value must be numeric or Signal."))
end

end
