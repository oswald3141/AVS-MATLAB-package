function mustBeAxisLimits(A)
% MUSTBEAXISLIMITS Validate that input defines axis limits
%
%   MUSTBEAXISLIMITS(A) throws an error if A is not "auto" or a 2-element
%   vector with increasing real numbers.

if is_char_row_vector(A) || (isstring(A) && isscalar(A))
    if A == "auto"
        return;
    else
        throwAsCaller(MException( ...
            "mustBeAxisLimits:invalidLimits", ...
            "The input does not define axis limits."));
    end
end

if ~(is_finite_real(A) && isvector(A) && (length(A) == 2) && (A(2) > A(1)))
    throwAsCaller(MException( ...
        "mustBeAxisLimits:invalidLimits", ...
        "The input does not define axis limits."));
end

    function tf = is_char_row_vector(text)
        tf = ischar(text) && (isrow(text) || isequal(size(text),[0 0]));
    end

    function tf = is_finite_real(a)
        tf = (isnumeric(a) || islogical(a)) && isreal(a) && allfinite(a);
    end

end
