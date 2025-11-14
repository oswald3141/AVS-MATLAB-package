function r = bsxfun(fun, a, b, preallocLength)
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
%   R = BSXFUN(FUN, A, B, PREALLOCLENGTH) Optional argument determines the
%   length of a Signal used for the result array preallocation. By default,
%   it is equal to the length of a(1).

arguments
    fun (1,1) function_handle
    a Signal
    b {mustHaveCompatibleSizes(a, b)}

    preallocLength { ...
        mustBeScalarOrEmpty, mustBePositive, mustBeInteger} = [];
end

if isempty(preallocLength)
    opts.PreallocationLength = a(1).n;
end

[aIdx, bIdx] = get_bsx_out_idx_combinations(size(a), size(b));

r = createArray(size(aIdx), "FillValue", Signal( ...
    zeros(1, opts.PreallocationLength, ...
        "like", 1+1j*double(a(1).isComplex)), ...
    1));

for i = 1:numel(r)
    r(i) = fun(a(aIdx(i)), b(bIdx(i)));
end

end
