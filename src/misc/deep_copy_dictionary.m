function d = deep_copy_dictionary(d)
% DEEP_COPY_DICTIONARY Create a deep copy of a dictionary
%
%   D = DEEP_COPY_DICTIONARY(D) creates a copy of a dictionary. If a value
%   V with a key K in dictionary D is a handle class implementing the
%   "copy" method (a subclass of "matlab.mixin.Copyable"), V in the new
%   dictionary is assigned as copy(D(K)). If the handle class of V does not
%   implement the "copy" method, an exception is thrown. If V is a
%   dictionary itself, DEEP_COPY_DICTIONARY is called on it. Value classes
%   are copied as usually.

arguments
    d (1,1) dictionary
end

for k = keys(d)
    if isa(d(k), 'dictionary')
        d(k) = deep_copy_dictionary(d(k));
    elseif isa(d(k), 'handle')
        if isa(d(k), 'matlab.mixin.Copyable')
            d(k) = copy(d(k));
        else
            throw(MException( ...
                'deep_copy_dictionary:objectNotCopyable', ...
                "The value of key ""%s"" is of class ""%s"" that " + ...
                "does not implement method ""copy""."));
        end
    else
        % value, no special action needed
    end
end

end
