function [evmRms] = calc_evm_rms(reference_symbs, estimated_symbs)
% CALC_EVM_RMS Calculate root mean squared EVM normalized to the reference
% signal power
%
%   [EVMRMS] = CALC_EVM_RMS(REFERENCE_SYMBS, ESTIMATED_SYMBS) calculates
%   root mean squared error vector magnitude for the signal ESTIMATED_SYMBS
%   normalized to the power of the reference signal REFERENCE_SYMBS.
%
%   See also: CALC_ACLR

arguments(Input)
    reference_symbs {mustBeNumeric}
    estimated_symbs {mustBeNumeric, ...
        mustHaveSameSize(reference_symbs, estimated_symbs)}
end

p = sum(abs(reference_symbs).^2, 'all');
e = sum(abs(reference_symbs - estimated_symbs).^2, 'all');
evmRms = sqrt(e/p);

end
