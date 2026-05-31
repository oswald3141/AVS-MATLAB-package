classdef(Abstract) DeprecatedHandle < handle
    % DeprecatedHandle Mark a handle-class as deprecated
    %   Inherit this class to mark a handle-class as deprecated. Each time
    %   the target class is instantiated, a warning will be issued to
    %   notify the user that the class should not be used.

    methods
        function this = DeprecatedHandle()
            warnId = "AVS:deprecated";
            warnMsg = "The class is deprecated!";

            dbst = dbstack;
            if length(dbst) > 1
                callerName = strsplit(dbst(2).name, '.');
                if length(callerName) > 1
                    warnMsg = "Class '"+ callerName{1} +"' is deprecated!";
                end
            end

            warning(warnId, warnMsg);
        end
    end
end
