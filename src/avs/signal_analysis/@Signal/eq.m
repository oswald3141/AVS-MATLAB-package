function r = eq(a, b)
% EQ Checks if two signals are equal
%
%    R = NE(A, B) compares samples and sample rates of A and B, returns
%    True if they match. Disregards descriptions.
%    This call also represents overloaded "equality" operator, so it can
%    be performed as
%       R = A == B;

assert(isa(a, "Signal") && isa(b, "Signal"), ...
    "Signal:comparisonNotDefined", ...
    "Comparison is supported only for to objects of Signal.");

r = isequal(a.samples, b.samples) && (a.Fs == b.Fs);

end
