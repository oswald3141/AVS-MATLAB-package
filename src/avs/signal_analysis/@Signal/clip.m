function this = clip(this, type, maxValue, minValue)
% CLIP Clip samples to the specified boundries
%
%   THIS = CLIP(THIS, TYPE, MAXVALUE, MINVALUE) limits the real part (if
%   TYPE is set to "re"), imaginary part (if TYPE is set to "im"), both of
%   them (if TYPE is set to "reim", or the absolute value (if TYPE is set
%   to "abs") of the samples to the [minValue; maxValue] range.
%   MAXVALUE must be greater that or equal to MINVALUE.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments(Input)
    this (1,1) Signal
    type {mustBeMember(type, ["re" "im", "reim", "abs"])}
    maxValue (1,1) {mustBeReal} = Inf;
    minValue (1,1) {mustBeReal, ...
        mustBeLessThanOrEqual(minValue, maxValue)} = -Inf;

end

if this.isComplex
    if type == "re"
        this.samples = ...
            clip_real_array(real(this.samples), maxValue, minValue) + ...
            1j*imag(this.samples);
    elseif type == "im"
        this.samples = ...
            real(this.samples) + ...
            1j*clip_real_array(imag(this.samples), maxValue, minValue);
    elseif type == "reim"
        this.samples = ...
            clip_real_array(real(this.samples), maxValue, minValue) + ...
            1j*clip_real_array(imag(this.samples), maxValue, minValue);
    elseif type == "abs"
        if maxValue >= 0
            this.samples = ...
                clip_real_array( ...
                    abs(this.samples), maxValue, minValue).* ...
                exp(1j*angle(this.samples));
        end
    else
        assert(0);
    end
else
    if type == "im"
        return;
    elseif type == "abs"
        if maxValue >= 0
            this.samples = ...
                clip_real_array(this.samples, maxValue, -maxValue);
        end
    elseif type == "re" || type == "reim"
        this.samples = clip_real_array(this.samples, maxValue, minValue);
    else
        assert(0);
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
