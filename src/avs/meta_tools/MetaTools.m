classdef(Abstract, Sealed) MetaTools
    % MetaTools General-purpose meta object tools
    %   This is a collection of static functions which may be useful for
    %   working with meta objects.

    methods(Static)

        function obj = setprop(obj, propName, newVal, quiet)
            % Sets object's property

            arguments(Input)
                obj (1,1) {mustBeObject}
                propName {mustBeTextScalar}
                newVal
                quiet {mustBeMember(quiet, ["" "quiet"])} = "";
            end

            try
                obj.(propName) = newVal;
            catch ME
                if quiet == "quiet" && ...
                        (ME.identifier == "MATLAB:noPublicFieldForClass")
                    return;
                else
                    rethrow(ME);
                end
            end
        end

        function val = get_default_value(obj, propName)
            % Gets default value of a property

            arguments(Input)
                obj (1,1) {mustBeObject}
                propName {mustBeTextScalar}
            end

            mobj = metaclass(obj);
            propList = mobj.PropertyList;

            for i = 1:length(propList)
                if strcmp(propList(i).Name, propName)
                    if propList(i).HasDefault
                        val = propList(i).DefaultValue;
                        return;
                    else
                        throw(MException(...
                            "MetaTools:noDefaultValue", ...
                            "The property ""%s"" " + ...
                                "has no default value.", propName));
                    end
                end
            end

            throw(MException("MetaTools:noSuchProperty", ...
                "Class ""%s"" has no ""%s"" property.", ...
                    mobj.Name, propName));
        end
    end

end
