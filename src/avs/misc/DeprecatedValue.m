classdef(Abstract) DeprecatedValue
    methods
        function this = DeprecatedValue()
            warning("AVS:deprecated", "The class is deprecated!");
        end
    end
end
