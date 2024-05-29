classdef(Abstract, Sealed) MetaToolsForConstructor
    % MetaToolsForConstructor Meta object tools for use in constructor
    %   This is a collection of static functions which simplify meta object
    %   operations useful in object constructors.
    %   These functions must be called only from the constructor.

    methods(Static)

        function obj = assign_properties(obj, nameValArgs)
            % Assign properties from name-value arguments
            %   Takes a name-value arguments structure where the names
            %   correspond to the object's properties and sets the values
            %   of those properties.

            arguments(Input)
                obj (1,1) {mustBeObject}
                nameValArgs (1,1) {mustBeA(nameValArgs, "struct")}
            end
    
            fn = string(fieldnames(nameValArgs));
            for i = 1:length(fn)
                obj.(fn(i)) = nameValArgs.(fn(i));
            end
        end

        function [own, rest] = filter_own_properties(namedArgStruct)
            % Filter name-value arguments to get only own properties
            %   Splits a name-value arguments structure to two. The first
            %   one contains only properties defined in the caller's class
            %   (not its parent) and the second one - the rest of the
            %   name-value pairs.

            arguments(Input)
                namedArgStruct (1,1) {mustBeA(namedArgStruct, "struct")}
            end

            objClassName = string(extractBefore([dbstack(1).name], '.'));
            mobj = meta.class.fromName(objClassName);
            propList = [mobj.PropertyList];
            
            ownNames = string.empty();

            for i = 1:length(propList)
                p = propList(i);

                if p.DefiningClass.Name == objClassName
                    ownNames = [ownNames string(p.Name)]; %#ok<AGROW>
                end
            end

            rest = namedArgStruct;
            rest = rmfield_quiet(rest, ownNames);

            own = namedArgStruct;
            own = rmfield_quiet(own, fieldnames(rest));
        end

    end

end
