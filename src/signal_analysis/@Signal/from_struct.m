function this = from_struct(s)
% FROM_STRUCT Create a Signal object from a structure
%
%   THIS = FROM_STRUCT(S) reads "samples", "Fs", and "description" fields
%   from S and calls Signal constructor.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    s (1,1) {mustBeA(s, "struct")}
end

this = Signal(s.samples, s.Fs, s.description);

end
