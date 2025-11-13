function mustBeCompatible(A, B)

as = size(A);
bs = size(B);

ml = max(length(as), length(bs));
as(end+1:ml) = 1;
bs(end+1:ml) = 1;

if ~all((as == bs) | (as == 1 | bs == 1))
    throwAsCaller(MException( ...
        "Signal:validators:mustHaveCompatibleSizes", ...
        "Arrays must have compatible sizes."));
end

if isa(A, "Signal") && isa(B, "Signal")
    [aIdx, bIdx] = get_bsx_out_idx_combinations(as, bs);

    for i = 1:numel(aIdx)
        na = A(aIdx(i)).n;
        nb = B(bIdx(i)).n;
        if na ~= nb
            if na ~= 1 && nb ~= 1
                throwAsCaller(MException( ...
                    "Signal:validators:mustBeCompatible", ...
                    "Signals must have same length. " + ...
                    "Lengths of A(%i) and B(%i) differ.", ...
                    aIdx(i), bIdx(i)));
            end
        end

        if ~(unsafe_almeq(A(aIdx(i)).Fs, B(bIdx(i)).Fs))
            throwAsCaller(MException( ...
                "Signal:validators:mustBeCompatible", ...
                "Signals must have same sample rate. " + ...
                "Rates of A(%i) and B(%i) differ.", aIdx(i), bIdx(i)));
        end
    end
end

    function r = unsafe_almeq(a, b)
        abs_th = realmin;
        epsilon = 2^-45; % 128*eps()
        diff = abs(a - b);
        norm = min(abs(a+b), realmax);
        r = diff < max(abs_th, epsilon*norm);
    end

end
