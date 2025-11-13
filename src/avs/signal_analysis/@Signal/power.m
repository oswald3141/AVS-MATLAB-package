function r = power(a, b)
% POWER Raises signal into a given power
%
%    R = POWER(A, B) raises each sample of each element of A into a
%    corresponding power from B. B must be a numeric array. Performs
%    dimensions expansion if necessary.
%    This call also represents overloaded "power" operator, so it can be
%    performed as
%       R = A.^B;

assert(isnumeric(b), ...
    "Signal:powerMustBeNumeric", ...
    "The power's type can be numeric only.");

if ~isa(a, "Signal")
    [a, b] = swap(a,b);
end

if isa(b, "Signal")
    r = Signal.bsxfun(@f1, a, b);
else
    r = Signal.bsxfun(@f2, a, b);
end

    function a = f1(a, b)
        a.samples = a.samples.^b.samples;
    end

    function a = f2(a, b)
        a.samples = a.samples.^b;
    end

end
