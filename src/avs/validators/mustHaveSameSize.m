function mustHaveSameSize(A, B, allowEmpty)
% MUSTHAVESAMESIZE Validate that the variables have the same size
%
%   MUSTHAVESAMESIZE(A, B) throws an exception if A has a different size
%   than B.
%
%   MUSTHAVESAMESIZE(A, B, "allow-all-empties") does not throw an exception
%   if A is emtpy.

if nargin > 2
    if strcmp(allowEmpty, "allow-all-empties") && isempty(A)
        return;
    end
end

if ~isequal(size(A), size(B))
    throwAsCaller(MException( ...
        "mustHaveSameSize:sizesDiffer", ...
        "The variables must have the same size." ...
    ));
end

end
