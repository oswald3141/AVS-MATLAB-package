function r = bsxfun(fun, a, b, preallocVal)
% BSXFUN Apply element-wise operation with implicit expansion enabled
%
%   R = BSXFUN(FUN, A, B) applies an element-wise binary operation
%   specified by the function handle FUN to arrays A and B.
%
%   A must be an object of "Signal" class.
%   B can be of any type as long as it is supported by FUN.
%
%   A and B must have sizes that are compatible for a binary operation.
%   Two arrays have compatible sizes if, for every dimension, the dimension
%   sizes of the arrays are either the same or one of them is 1.
%   FUN must be a function handle accepting two inputs.
%
%   R = BSXFUN(FUN, A, B, PREALLOCVAL) Optional argument contains an object
%   used for the result array preallocation. By default, it is a Signal,
%   whose length is equal to A(1).n.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    fun (1,1) function_handle
    a Signal
    b {mustHaveCompatibleSizes(a, b)}

    preallocVal (1,1) = Signal( ...
        zeros(1, a(1).n, "like", 1+1j*double(isreal(a))), 1);
end

[aIdx, bIdx] = calc_indices_for_bsx(size(a), size(b));

r = createArray(size(aIdx), "FillValue", preallocVal);

for i = 1:numel(r)
    r(i) = fun(a(aIdx(i)), b(bIdx(i)));
end

end
