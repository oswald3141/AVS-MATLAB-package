function this = apply(this, func)
% APPLY Apply a function to signal
%
%   THIS = APPLY(THIS, FUNC) calles FUNC on the signal's samples vector and
%   saves the result to the same signal.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    this (1,1) Signal
    func (1,1) {mustBeA(func, "function_handle")}
end

this.samples = func(this.samples);

end
