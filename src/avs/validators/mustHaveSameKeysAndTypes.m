function mustHaveSameKeysAndTypes(d1, d2)
% MUSTHAVESAMEKEYSANDTYPES Validate that dicts has the same types and keys
%
%   MUSTHAVESAMEKEYSANDTYPES(D1, D2) throws an error if the types or keys
%   of D1 and D2 differ.

if class(d1) ~= "dictionary" || class(d2) ~= "dictionary"
    throwAsCaller(MException( ...
        "mustHaveSameKeysAndTypes:invalidDictionary", ...
        "One of the inputs is not a dictionary."));
end

[keyType1, valType1] = types(d1);
[keyType2, valType2] = types(d2);

if keyType1 ~= keyType2
    throwAsCaller(MException( ...
        "mustHaveSameKeysAndTypes:invalidDictionary", ...
        "The key types must be the same."));
end

if valType1 ~= valType2
    throwAsCaller(MException( ...
        "mustHaveSameKeysAndTypes:invalidDictionary", ...
        "The value types must be the same."));
end

keys1 = sort(d1.keys);
keys2 = sort(d2.keys);

if ~isequal(keys1, keys2)
    throwAsCaller(MException( ...
        "mustHaveSameKeysAndTypes:invalidDictionary", ...
        "The keys must be the same."));
end

end
