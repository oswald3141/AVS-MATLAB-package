function varargout = bypass(varargin)
% BYPASS Returns its first argument
%
%   [ARG1, ARG2, ..., ARGN] = BYPASS(ARG1, ARG2, ..., ARGM) takes an
%   arbitrary number of arguments and returns all of them.
%   If the number of output arguments exceeds the number of input ones, it
%   sets the excessive ones to [].

for i = nargout:-1:1
    if i <= nargin
        varargout{i} = varargin{i};
    else
        varargout{i} = [];
    end
end

end
