function a = bsxfun_arith(fun, a, b)
% BSXFUN_ARITH Optimally compute bsxfun for a arithmetic operation

if isequal(size(a), size(b))
    for i = 1:numel(a)
        a(i) = fun(a(i), b(i));
    end
elseif isscalar(a)
    if isa(b, "Signal")
        for i = 1:numel(b)
            b(i) = fun(a, b(i));
        end
        a = b;
    else
        a = repmat(a, size(b));
        for i = 1:numel(a)
            a(i) = fun(a(i), b(i));
        end
    end
elseif isscalar(b)
    for i = 1:numel(a)
        a(i) = fun(a(i), b);
    end
else
    [aIdx, bIdx] = calc_indices_for_bsx(size(a), size(b));
    r = Signal.createArray(size(aIdx), "Like", a(1), "Complex", isreal(a));
    for i = 1:numel(r)
        r(i) = fun(a(aIdx(i)), b(bIdx(i)));
    end
    a = r;
end

end
