function r = ne(a, b)
% NE Checks if two signals are not equal
%
%   R = EQ(A, B) compares samples and sample rates of A and B disregarding
%   the descriptions.

if ~isa(a, "Signal") || ~isa(b, "Signal")
    error("AVS:Signal:ComparisonNotDefined", ...
        "Comparison between %s and %s is not supported.", ...
        class(a), class(b));
end

r = Signal.bsxfun(@f1, a, b, false);

    function r = f1(a, b)
        r = ~unsafe_almeq(a.Fs, b.Fs) || ...
            ~isequal(a.samples, b.samples);
    end

end
