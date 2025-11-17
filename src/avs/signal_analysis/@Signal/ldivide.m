function a = ldivide(a, b)
% LDIVIDE Left array division with another signal or a numeric array
%
%   A = LDIVIDE(A, B) divides B by A if one of them is Signal and the
%   other one is either Signal or a numeric array. Performs dimensions
%   expansion if necessary.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    a 
    b {mustHaveCompatibleSizes(a, b)}
end

aIsSig = isa(a, "Signal");
bIsSig = isa(b, "Signal");
aIsNum = isnumeric(a);
bIsNum = isnumeric(b);

if aIsSig && bIsSig
    a = bsxfun_arith(@ldivide_sig_sig, a, b);
elseif aIsSig && bIsNum
    a = bsxfun_arith(@ldivide_sig_num, a, b);
elseif bIsSig && aIsNum
    b = bsxfun_arith(@ldivide_sig_num, b, a);
    a = b;
else
    throw(MException( ...
        "Signal:ldivide:mustBeNumericOrSignal", ...
        "Value must be numeric or Signal."))
end

end
