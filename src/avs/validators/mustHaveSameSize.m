function mustHaveSameSize(A, B, varargin)
% MUSTHAVESAMESIZE Validate that the variables have the same size
%
%   MUSTHAVESAMESIZE(A, B) throws an exception if A has a different size
%   than B.
%
%   MUSTHAVESAMESIZE(A, B, "allow-all-empties") does not throw an exception
%   if A is emtpy. Can be useful if A is an ignorable parameter.
%
%   MUSTHAVESAMESIZE(A, B, "allow-scalar") does not throw an exception
%   if A is scalar. Can be useful since a scalar can be shaped into any
%   size by repetition.
%
%   MUSTHAVESAMESIZE(A, B, "allow-all-empties", "allow-scalar") a
%   combination of the two previous options.

if nargin > 2
    for i = 1:length(varargin)
        if strcmp(varargin{i}, "allow-all-empties")
            if isempty(A)
                return;
            end
        elseif strcmp(varargin{i}, "allow-scalar")
            if isscalar(A)
                return;
            end
        else
            throwAsCaller(MException( ...
                "mustHaveSameSize:invalidComparisonParameter", ...
                "The value of the comparison strictness " + ...
                    "argument is not recognized." ...
            ));
        end
    end
end

if ~isequal(size(A), size(B))
    throwAsCaller(MException( ...
        "mustHaveSameSize:sizesDiffer", ...
        "The variables must have the same size." ...
    ));
end

end
