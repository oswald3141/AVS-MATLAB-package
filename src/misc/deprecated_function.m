function deprecated_function()
% DEPRECATED_FUNCTION Mark function as deprecated
%
%   DEPRECATED_FUNCTION() issues a warning notifying the user that the
%   caller function is deprecated.

warnId = "AVS:deprecated";
warnMsg = "The function is deprecated!";

dbst = dbstack;
if length(dbst) > 1
    warnMsg = "Function '" + dbst(2).name + "' is deprecated!";
end

warning(warnId, warnMsg);

end
