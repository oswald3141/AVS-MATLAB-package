function unreachable()
% UNREACHABLE Throw an error if line reached
%
%   UNREACHABLE() marks a line that is supposed to be never reached, e.g.
%   otherwise clause of a swith-case. If the line is reached, the function
%   throws an exception.
%
%   See also: TODO, DO_NOTHING

throwAsCaller(MException('AVS:unreachable', ...
    'This line is supposed to be unreachable.'));

end
