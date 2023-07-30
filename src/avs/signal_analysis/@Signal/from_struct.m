function this = from_struct(s)
% FROM_STRUCT Create a Signal object from a structure
%
%    THIS = FROM_STRUCT(S) reads "samples", "Fs", and "description" fields
%    from S and calls Signal constructor.

arguments(Input)
    s (1,1) {mustBeA(s, "struct")}
end

this = Signal(s.samples, s.Fs, s.description);

end
