function a = power(a, b)
% POWER Raise each sample to the given power
%
%   A = POWER(A, B) raises each sample of each element of A into a
%   corresponding power from B. A and be must be a Signal or a numeric
%   array. Performs dimensions expansion if necessary.
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
