classdef WelchSpectrum
% WELCHSPECTRUM Class storing Welch spectrum of a Signal
%
%   See also: SIGNAL, WELCHSPECTRUMANALYZER, WELCHSPECTRUMPLOTTER

    properties(SetAccess = ?WelchSpectrumAnalyzer)
        % Spectrum (power)
        power (1,:) {mustBeVector(power, "allow-all-empties"), ...
            mustBeNonnegative} = [];
        % Spectrum (phase)
        phase (1,:) {mustBeVector(phase, "allow-all-empties"), ...
            mustBeReal} = [];
        % Sample rate
        Fs {mustBeScalarOrEmpty, mustBePositive} = [];
        % Frequencies for X axes
        freqGrid (1,:) {mustBeVector(freqGrid, "allow-all-empties"), ...
            mustBeReal} = [];
    end

    properties
        % Optional spectrum description
        description {mustBeTextScalar} = "";
    end

    properties(SetAccess = ?WelchSpectrumAnalyzer)
        % Length of the segment for Welch spectrum calculation
        segmentLength (1,1) {mustBeNonnegative} = 0;
        % Absolute overlap between the adjacent segments 
        numOverlapPts (1,1) {mustBeNonnegative, mustBeInteger} = 0;
        % Function generating spectral window
        get_spwin (1,1) {mustBeA(get_spwin, "function_handle")} = ...
            @(L) hann(L, "periodic");
        % Number of segments generated in computation
        nSegments (1,1) {mustBeNonnegative, mustBeInteger} = 0
        % Function aggregating power traces
        powTraceFunc {mustBeTextScalar} = "";
        % Function aggregating phase traces
        phsTraceFunc {mustBeTextScalar} = "";
        % Applied spectral window
        window {mustBeTextScalar} = "";
    end

    methods(Access = public)
        % Shows the spectrum using WelchSpectrumPlotter with default args
        plot(this, pltType)
    end
end
