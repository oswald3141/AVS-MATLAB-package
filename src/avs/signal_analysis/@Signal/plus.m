function r = plus(a, b)
% PLUS Adds signal to another signal or a numeric value
%
%    R = PLUS(A, B) adds A to B if one of them is Signal and the
%    other one is either Signal or a numeric value. Performs dimensions
%    expansion if necessary.
%    This call also represents overloaded "plus" operator, so it can be
%    performed as
%       R = A + B;


if ~isa(a, "Signal")
    [a, b] = swap(a,b);
end

if isa(b, "Signal")
    r = Signal.bsxfun(@f1, a, b);
elseif isnumeric(b)
    r = Signal.bsxfun(@f2, a, b);
else
    throw(MException( ...
        "Signal:arithmeticBinaryOpeation:mustBeNumericOrSignal", ...
        "Value must be numeric or Signal."))
end

    function a = f1(a, b)
        check_arith_bin_op_compatibility(a, b);
        a.samples = a.samples + b.samples;
    end

    function a = f2(a, b)
        a.samples = a.samples + b;
    end

end
