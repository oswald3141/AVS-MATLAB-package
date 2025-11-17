function r = ne(a, b)
% NE Checks if two signals are not equal
%
%   R = EQ(A, B) compares samples and sample rates of A and B disregarding
%   the descriptions. The sample rates are compared taking into accout the
%   representation accuracy of the "double" type. Performs dimensions
%   expansion if necessary.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    a 
    b {mustHaveCompatibleSizes(a,b)}
end

if ~isa(a, "Signal") || ~isa(b, "Signal")
    error("AVS:Signal:ComparisonNotDefined", ...
        "Comparison between %s and %s is not supported.", ...
        class(a), class(b));
end

r = Signal.bsxfun(@f1, a, b, false);

    function r = f1(a, b)
        r = ~unsafe_almeq(a.Fs, b.Fs) || ...
            ~isequal(a.samples, b.samples);
    end

end
