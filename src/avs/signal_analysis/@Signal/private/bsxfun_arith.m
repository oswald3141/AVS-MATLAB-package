function a = bsxfun_arith(fun, a, b)

if isequal(size(a), size(b))
    for i = 1:numel(a)
        a(i) = fun(a(i), b(i));
    end
elseif isscalar(a)
    for i = 1:numel(b)
        b(i) = fun(a, b(i));
    end
    a = b;
elseif isscalar(b)
    for i = 1:numel(a)
        a(i) = fun(a(i), b);
    end
else
    [aIdx, bIdx] = get_bsx_out_idx_combinations(size(a), size(b));
    r = createArray(size(aIdx), "FillValue", Signal( ...
        zeros(1, a(1).n, "like", 1+1j*double(a(1).isComplex)), 1));
    for i = 1:numel(r)
        r(i) = fun(a(aIdx(i)), b(bIdx(i)));
    end
    a = r;
end

end
