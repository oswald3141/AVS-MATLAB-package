classdef(Abstract) DeprecatedHandle < handle
    methods
        function this = DeprecatedHandle()
            warning("AVS:deprecated", "The class is deprecated!");
        end
    end
end
