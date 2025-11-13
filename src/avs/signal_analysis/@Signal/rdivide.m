function r = rdivide(a, b)
% RDIVIDE Divides signal with another signal or a numeric value
%
%    R = RDIVIDE(A, B) divides A by B if one of them is Signal and the
%    other one is either Signal or a numeric value. Performs dimensions
%    expansion if necessary.
%    This call also represents overloaded "right divide" operator, so it
%    can be performed as
%       R = A./B;

if ~isa(a, "Signal")
    [a, b] = swap(a,b);
end

if isa(b, "Signal")
    r = Signal.bsxfun(@f1, a, b);
else
    r = Signal.bsxfun(@f2, a, b);
end

    function a = f1(a, b)
        a.samples = a.samples./b.samples;
    end

    function a = f2(a, b)
        a.samples = a.samples./b;
    end

end
