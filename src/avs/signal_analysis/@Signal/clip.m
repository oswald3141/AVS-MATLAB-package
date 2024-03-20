function this = clip(this, component, maxValue, minValue)
% CLIP Clips samples to the specified boundries
%
%   S = CLIP(S, COMPONENT, MAXVALUE, MINVALUE) limits the real (if
%   COMPONENT is set to "re") or imaginary (if COMPONENT is set to "im")
%   part of the samples to the [minValue; maxValue] range. Returnes the
%   alteres copy of S.

arguments(Input)
    this (1,1) Signal
    component {mustBeMember(component, ["re" "im"])}
    maxValue (1,1) {mustBeReal} = Inf;
    minValue (1,1) {mustBeReal} = -Inf;

end

if this.isComplex
    if component == "re"
        this.samples = clip_real_array(this.re, maxValue, minValue) + ...
            1j*this.im;
    elseif component == "im"
        this.samples = this.re + ...
            1j*clip_real_array(this.im, maxValue, minValue);
    else
        assert(0);
    end
else
    if component == "im"
        return;
    else
        this.samples = clip_real_array(this.samples, maxValue, minValue);
    end
end

    function a = clip_real_array(a, maxval, minval)
        if ~isinf(maxval)
            a(a > maxval) = maxval;
        end
        
        if ~isinf(minval)
            a(a < minval) = minval;
        end
    end

end
