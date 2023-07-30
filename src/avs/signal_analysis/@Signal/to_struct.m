function s = to_struct(this)
% TO_STRUCT Convers a Signal object into a structure
%
%    S = TO_STRUCT(THIS) creates a structure with "samples", "Fs", and
%    "description" fields and copies the corresponding properties from THIS
%    to these fields.

s.samples = this.samples;
s.Fs = this.Fs;
s.description = this.description;

end
