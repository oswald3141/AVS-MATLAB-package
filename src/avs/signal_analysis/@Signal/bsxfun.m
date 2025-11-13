function r = bsxfun(fun, a, b)
% BSXFUN Apply element-wise operation with implicit expansion enabled
%
%   R = BSXFUN(FUN, A, B) applies the element-wise binary operation
%   specified by the function handle FUN to arrays A and B.

arguments
    fun (1,1) function_handle
    a Signal
    b {mustBeCompatible(a, b)}
end

[aIdx, bIdx] = get_bsx_out_idx_combinations(size(a), size(b));

r = createArray(size(aIdx), "FillValue", ...
    Signal(zeros(1, a(1).n, "like", 1+1j*double(a(1).isComplex)), 1));

for i = 1:numel(r)
    r(i) = fun(a(aIdx(i)), b(bIdx(i)));
end

end
