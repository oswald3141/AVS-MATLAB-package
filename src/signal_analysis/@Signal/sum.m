function r = sum(a, dim)
% SUM Sums signals
%
%   R = SUM(A) returns the sample-wise sum of the signals of A along the
%   first dimension whose size does not equal 1.
%   The signals in A must have the same length and sample rate.
%
%   R = SUM(A, "all") returns the sum of all signals of A.
%
%   R = SUM(A, DIM) returns the sum along dimension DIM.
%
%   R = SUM(A, VECDIM) sums the signals of A based on the dimensions
%   specified in the vector VECDIM.
%
%   Overall, this function behaves similarly to the built-in SUM.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    a
    dim = []; % dim, vecdim, or "all"
    % nanflag  does not make sense for Signal
end

aFs = [a.Fs];
aN = [a.n];

if ~all(unsafe_almeq(aFs, aFs(1)))
    error("Signal:sum:mustHaveSameFs", ...
        "Summing signals with different sample rates is not possible.");
end

if ~all(aN == aN(1))
    error("Signal:sum:mustHaveSameLengths", ...
        "Summing signals with different lengths is not possible.");
end

if (ischar(dim) && isrow(dim) || isstring(dim) && isscalar(dim)) && ...
                                                        strcmp(dim, "all")
    r = a(1);
    for i = 2:numel(a)
        r = r + a(i);
    end
elseif isempty(dim) || ...
                    (isrow(dim) && all(dim == floor(dim)) && all(dim > 0))   
    if isempty(dim)
        [~, dim] = find(size(a)-1, 1, 'first');
    end

    if ~isequal(unique(dim), dim)
        error("Signal:sum:vecDimsMustBeUniquePositiveIntegers", ...
            "Elements of a dimension vector must be unique.");
    end

    dim(dim > ndims(a) || size(a, dim) == 1) = [];
    r = a;

    for iDim = 1:length(dim)
        if iDim > 1
            a = r;
        end

        outIdxCombs = calc_indices_for_along_dim_operation(size(a), dim);

        r = Signal.createArray(size(outIdxCombs), ...
            "Like", a(1), "Complex", ~isreal(a));

        for ir = 1:numel(r)
            for ia = outIdxCombs{ir}
                r(ir) = r(ir) + a(ia);
            end
        end
    end
else
    error("Signal:sum:invalidDim", ...
        "Dimension argument must be a positive integer scalar, " + ...
        "a vector of unique positive integers, or 'all'.");
end

end
