function this = apply(this, func)
% APPLY Applies a function to the signal's samples
%
%   THIS = APPLY(THIS, FUNC) calles FUNC on the signal's samples vector.

arguments(Input)
    this (1,1) Signal
    func (1,1) {mustBeA(func, "function_handle")}
end

this.samples = func(this.samples);

end
