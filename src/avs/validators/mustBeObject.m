function mustBeObject(var)
% MUSTBEOBJECT Validate that a variable is some class instance
%
%   MUSTBEOBJECT(VAR) throws an error if the passed variable is not some
%   class instance. Instances of MATLAB numeric, logical, char, cell,
%   struct, and function handle classes are NOT considered to be class
%   instances.

if ~isobject(var)
    throwAsCaller(MException( ...
        "mustBeObject:notAnObject", ...
        "The input variable must be some class instance."))
end

end
