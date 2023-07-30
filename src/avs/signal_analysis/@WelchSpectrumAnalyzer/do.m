function varargout = do(this, sig)
% DO Compute Welch spectrum of signals
%
%   [SP1, ..., SPN] = DO(THIS, SIG1, ..., SIGN) calls WelchSpectrum.of()
%   for each signal (SIG1, ..., SIGN) with the options stored in this class
%   and returnes the results in the same order.

arguments(Input)
    this (1,1) WelchSpectrumAnalyzer
end

arguments(Input, Repeating)
    sig (1,1) Signal
end

if nargout == 0 % Optimization
    return;
end

opts = namedargs2cell(this.params);
varargout = cell(1, nargin-1);

[varargout{:}] = WelchSpectrum.of(sig{:}, opts{:});

end