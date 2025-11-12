function mustBeEvenPowerOfTwo(A)
% MUSTBEEVENPOWEROFTWO Validate that value is an even power of 2
%
%   MUSTBEEVENPOWEROFTWO(A) throws an error if A contains numbers which are
%   not an even power of 2. For example, 2^-2, 2^4, 2^8 or 2^-8 will not
%   cause an error, while 2^3, 2^5, 2^7 or 2^-11 will.
%
%   See also: MUSTBENATURALPOWEROFTWO

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeNumericOrLogical", ...
        "Value must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeReal", ...
        "Value must be real."));
end

if ~all(A > 0, 'all')
    throwAsCaller(MException( ...
        "AVS:validators:mustBePositive", ...
        "Value must be positive."));
end

if ~allfinite(A)
    throwAsCaller(MException( ...
        "AVS:validators:mustBeFinite", ...
        "Value must be finite."));
end

if ~all(mod(log2(A), 2) == 0, "all")
    throwAsCaller(MException( ...
        "AVS:validators:mustBeEvenPowerOfTwo", ...
        "Value must be an even power of two." ...
    ));
end

end
