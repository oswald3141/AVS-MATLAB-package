function v = get_field_safely(s, fieldname, defaultval)
% GET_FIELD_SAFELY Check if field is in structure and return its value
%
%   V = GET_FIELD_SAFELY(S, FIELDNAME) returns the value of FIELDNAME field
%   in structure S or an empty array if FIELDNAME is not a field of S.
%
%   V = GET_FIELD_SAFELY(_, DEFAULTVAL) if FIELDNAME is not a field of S,
%   returns DEFAULTVAL instead of an empty array.
%
%   See also: RMFIELD_QUIET


arguments
    s (1,1) struct
    fieldname {mustBeTextScalar}
    defaultval = [];
end

if isfield(s, fieldname)
    v = s.(fieldname);
else
    v = defaultval;
end

end
