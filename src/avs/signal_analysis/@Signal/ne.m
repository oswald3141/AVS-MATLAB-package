function r = ne(a, b)
% NE Checks if two signals are not equal
%
%    R = NE(A, B) compares samples and sample rates of A and B, returns
%    True if they do not match. Disregards descriptions.
%    This call also represents overloaded "inequality" operator, so it can
%    be performed as
%       R = A ~= B;

assert(isa(a, "Signal") && isa(b, "Signal"), ...
    "Signal:comparisonNotDefined", ...
    "Comparison is supported only for to objects of Signal.");

r = ~isequal(a.samples, b.samples) || (a.Fs ~= b.Fs);

end
