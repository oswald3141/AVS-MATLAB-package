function fail(varargin)
% FAIL Throws an unknown error exception
%
%   FAIL(ARG1, ARG2, ..., ARGN) takes an arbitrary number of arguments and
%   throws and unknown error exception.

throwAsCaller(MException("fail:unknownError", "An unknown error occured."))

end
