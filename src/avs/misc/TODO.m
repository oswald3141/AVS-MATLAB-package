function TODO(addmsg, severity)
% TODO Throw an error if there is no implementation
%
%   TODO() marks a place that is not yet implemented. If the place is
%   reached, TODO throws an error with an explanatory message.
%
%   TODO(STR) adds STR to the message of the thrown error. If STR is empty,
%   it is ignored and the behaviour is the same as of TODO().
%
%   TODO(STR, SEVERITY) throws an error if SEVERITY is "error", and
%   displays a warning if it is "warning".
%
%   See also: UNREACHABLE, DO_NOTHING


arguments
    addmsg {mustBeTextScalar} = "";
    severity {mustBeMember(severity, ["error" "warning"])} = "error";
end

id = 'AVS:TODO';

if addmsg == ""
    msg = 'The implementation is not finished.';
else
    msg = ['The implementation is not finished: ' ...
        convertStringsToChars(addmsg)];
end

if severity == "error"
    throwAsCaller(MException(id, msg));
elseif severity == "warning"
    warning(id, msg);
else
    unreachable();
end

end
