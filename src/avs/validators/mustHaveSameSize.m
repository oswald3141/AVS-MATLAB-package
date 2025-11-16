function mustHaveSameSize(A, B, flag1, flag2)
% MUSTHAVESAMESIZE Validate that values have the same size
%
%   MUSTHAVESAMESIZE(A, B) throws an error if sizes of A and B differ.
%   size is called to determine the size.
%
%   MUSTHAVESAMESIZE(A, B, FLAG1, FLAG2) Optional flags FLAG1 and FLAG2
%   indicate if A can be empty or scalar.
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
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text
%
%   See also: MUSTHAVESAMESIZE

allowAllEmpty = false;
allowScalar = false;

for i = 1:nargin-2
    if i == 1
        flag = flag1;
    elseif i == 2
        flag = flag2;
    end

    if ~(ischar(flag) && isrow(flag)) && ...
                                        ~(isstring(flag) && isscalar(flag))
        error("AV:validation:UnableToConvert", ...
            "Invalid argument at position %i. " + ...
            "Value must be 'allow-all-empties' or 'allow-scalar'.", i+2);
    end

    if strcmp(flag, "allow-all-empties")
        if ~allowAllEmpty
            allowAllEmpty = true;
        else
            error( ...
                "AV:validatorUsage:ConflictingSizeComparisonOptions", ...
                "Repeating 'allow-all-empties' is not allowed.");
        end
    elseif strcmp(flag, "allow-scalar")
        if ~allowScalar
            allowScalar = true;
        else
            error( ...
                "AV:validatorUsage:ConflictingSizeComparisonOptions", ...
                "Repeating 'allow-scalar' is not allowed.");
        end
    else
        error("AV:validation:UnableToConvert", ...
            "Invalid argument at position %i. " + ...
            "Value must be 'allow-all-empties' or 'allow-scalar'.", i+2);
    end
end

if ~(allowAllEmpty && isempty(A)) && ~(allowScalar && isscalar(A))
    if ~isequal(size(A), size(B))
        throwAsCaller(MException( ...
            "AV:validators:mustHaveSameSize", ...
            "Size of value must be [%s].", num2str(size(B)) ...
        ));
    end
end

end
