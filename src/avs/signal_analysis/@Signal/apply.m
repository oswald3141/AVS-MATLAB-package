function r = apply(this, func)
% APPLY Applies a function to the signal's samples
%
%   R = APPLY(THIS, FUNC) calles FUNC on the signal's samples vector.
%   Leaves "description" property of THIS unchanged.

arguments(Input)
    this (1,1) Signal
    func (1,1) {mustBeA(func, "function_handle")}
end

r = this;
r.samples = func(r.samples);

end
