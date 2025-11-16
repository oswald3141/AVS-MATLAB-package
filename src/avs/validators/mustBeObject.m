function mustBeObject(A)
% MUSTBEOBJECT Validate that value is an object of a MATLAB class
%
%   MUSTBEOBJECT(A) throws an error if A is not object of a MATLAB class.
%   isobject is called to determine if A is an object of a MATLAB class.
%   Instances of MATLAB numeric, logical, char, cell, struct, and function
%   handle classes are NOT considered to be objects. 
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

if ~isobject(A)
    throwAsCaller(MException( ...
        "AV:validators:mustBeObject", ...
        "Value must be a class instance."))
end

end
