function a = createArray(sz, args)
% CREATEARRAY Create array of Signal
%
%   A = CREATEARRAY(SZ1,...,SZN) creates an array of Signal. Each signal
%   has zero length and empty sample rate. SZ1,...SZN is the size of each
%   dimension passed as separate arguments.
%
%   A = CREATEARRAY(SZ) same as previous, but the size of each dimension is
%   passed as a row vector.
%
%   A = CREATEARRAY(_,Name=Value) accepts the following name-value
%   arguments:
%       Like    - example Signal, whose length, sample rate, and complexness
%                 will be used in elements of a.
%       Fs      - sample rate of signals in A; overrides Like.
%       N       - length of signals in A; overrides Like.
%       Complex - logical flag determining if signals in A are complex;
%                 overrides Like.
%   If N > 0, all samples are set to zero.

arguments(Repeating)
    sz {mustBeNonnegative, mustBeInteger}
end

arguments
    args.Like (1,1) Signal = Signal();
    args.Fs {mustBeScalarOrEmpty, mustBePositive}
    args.N (1,1) {mustBeNonnegative, mustBeInteger}
    args.Complex (1,1) logical
end

Fs = get_field_safely(args, "Fs", args.Like.Fs);
N = get_field_safely(args, "N", args.Like.n);
c = get_field_safely(args, "Complex", ~isreal(args.Like));

a = createArray(sz{:}, "FillValue", ...
    Signal(zeros(1, N, "like", 1+1j*double(c)), Fs));

end
