function r = bsxfun(fun, a, b, preallocVal)
% BSXFUN Apply element-wise operation with implicit expansion enabled
%
%   R = BSXFUN(FUN, A, B) applies the element-wise binary operation
%   specified by the function handle FUN to arrays A and B.
%   A must be an object of "Signal" class.
%   B can be of any type as long as it is supported by FUN.
%   A and be must have sizes that are compatible for a binary operation.
%   Two arrays have compatible sizes if, for every dimension, the dimension
%   sizes of the arrays are either the same or one of them is 1.
%   FUN must be a function handle accepting two inputs and returning an
%   object of "Signal" class.
%
%   R = BSXFUN(FUN, A, B, PREALLOCVAL) Optional argument contains an object
%   used for the result array preallocation. By default, it is a Signal,
%   whose length is equal to A(1).n.

arguments
    fun (1,1) function_handle
    a Signal
    b {mustHaveCompatibleSizes(a, b)}

    preallocVal (1,1) = Signal( ...
        zeros(1, a(1).n, "like", 1+1j*double(a(1).isComplex)), 1);
end

[aIdx, bIdx] = get_bsx_out_idx_combinations(size(a), size(b));

r = createArray(size(aIdx), "FillValue", preallocVal);

for i = 1:numel(r)
    r(i) = fun(a(aIdx(i)), b(bIdx(i)));
end

end
