function mustBeBinary(A)
% MUSTBEBINARY Validate that value is binary
%
%   MUSTBEBINARY(A) throws an error if A contains any numbers other than
%   "0" or "1".

if ~isnumeric(A) && ~islogical(A)
    throwAsCaller(MException( ...
        "mustBeBinary:nonNumericOrLogicalInput", ...
        "The input must be numeric or logical."));
end

if ~isreal(A)
    throwAsCaller(MException( ...
        "mustBeBinary:nonRealInput", ...
        "The input must be real."));
end

if ~allfinite(A)
    throwAsCaller(MException( ...
        "mustBeBinary:nonFiniteInput", ...
        "The input must be finite."));
end

binary_ = all((A == 0) | (A == 1), "all");

if ~binary_
    throwAsCaller(MException( ...
        "mustBeBinary:notABinary", ...
        "The array must contain only zeros and ones." ...
    ));
end

end
