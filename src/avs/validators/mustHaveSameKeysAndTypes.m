function mustHaveSameKeysAndTypes(d1, d2)
% MUSTHAVESAMEKEYSANDTYPES Validate that dict. have same types and keys
%
%   MUSTHAVESAMEKEYSANDTYPES(D1, D2) throws an error if the types or keys
%   of D1 and D2 differ.

if class(d1) ~= "dictionary"
    throwAsCaller(MException( ...
        "AVS:validators:mustBeA", ...
        "Invalid argument at position 1. " + ...
        "Value must be of 'dictionary' type."));
end

if class(d2) ~= "dictionary"
    throwAsCaller(MException( ...
        "AVS:validators:mustBeA", ...
        "Invalid argument at position 2. " + ...
        "Value must be of 'dictionary' type."));
end

[keyType1, valType1] = types(d1);
[keyType2, valType2] = types(d2);

if keyType1 ~= keyType2
    throwAsCaller(MException( ...
        "AVS:validators:mustHaveSameKeysAndTypes", ...
        "Values must have the same key types."));
end

if valType1 ~= valType2
    throwAsCaller(MException( ...
        "AVS:validators:mustHaveSameKeysAndTypes", ...
        "Values must have the same value types."));
end

keys1 = sort(d1.keys);
keys2 = sort(d2.keys);

if ~isequal(keys1, keys2)
    throwAsCaller(MException( ...
        "AVS:validators:mustHaveSameKeysAndTypes", ...
        "Values must have the same keys."));
end

end
