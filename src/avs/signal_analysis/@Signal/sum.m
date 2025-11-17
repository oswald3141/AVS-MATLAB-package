function r = sum(a, dim)
% SUM Sums signals
%
%   R = SUM(A) returns the sum of the signals of A along the array
%   dimension DIM. The signals must have the same length and sample rate.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    a
    dim = 1; % dim, vecdim, or "all"
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
        dim = 1;
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

        outIdxCombs = get_alongdim_out_idx_combinations(size(a), dim);

        r = createArray(size(outIdxCombs), "FillValue", ...
            Signal( ...
                zeros(1, a(1).n, "like", 1+1j*double(a(1).isComplex)), ...
                a(1).Fs));

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
