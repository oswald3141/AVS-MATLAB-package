function s = rmfield_quiet(s, field)
% RMFIELD_QUIET Remove fields from a structure array
%
%   S = RMFIELD(S,FIELD) removes the field specified by FIELD from the 
%   m x n structure array S. Unlike MATLAB's rmfield, does not throw an
%   exception if the field does not exist.

try
    s = rmfield(s, field);
catch ME
    if ~strcmp(ME.identifier, 'MATLAB:rmfield:InvalidFieldname')
        rethrow(ME);
    end

    % field has only one field name and it's not in s
    if ischar(field)
        return;
    end

    if iscell(field) || isstring(field)
        field = field(:);

        % Remove all invalid field names
        n = length(field);
        for i = n:-1:1
            if ~isfield(s, field{i})
                field(i) = [];
            end
        end

        % Try again
        s = rmfield(s, field);
        return;
    end

    % If rmfield threw this exception, no other type of field is possible
end

end
