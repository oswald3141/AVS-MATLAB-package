classdef WelchSpectrum
% WELCHSPECTRUM A class computing and storing Welch spectrum of a Signal
%
%   Please, see "of" method's source code for further details. Use this
%   method instead of the constructor.
%
%   See also: WELCHSPECTRUMANALYZER, WELCHSPECTRUMPLOTTER

    properties(SetAccess = private, GetAccess = public)
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

    properties(SetAccess = public, GetAccess = public)
        % Optional spectrum description
        description {mustBeTextScalar} = "";
    end

    properties(SetAccess = private, GetAccess = public)
        % Length of the segment for Welch spectrum calculation. Equivalent
        % to the FFT size
        segmentLength (1,1) {mustBeNonnegative} = 0
        % Relative overlap between the adjacent segments 
        relativeOverlap (1,1) ...
            {mustBeInRange(relativeOverlap, 0, 1, "exclude-upper")} = 0.5
        % Function used for combining the segments' power spectra
        powTraceFuncName ...
            {mustBeMember(powTraceFuncName, ...
                ["Average", "MaxHold", "MinHold"])} = "Average"
        % Function used for combining the segments' phase spectra
        phsTraceFuncName ...
            {mustBeMember(phsTraceFuncName, ...
                ["Average", "MaxHold", "MinHold"])} = "Average"
        % Function generating spectral window
        get_spwin (1,1) {mustBeA(get_spwin, "function_handle")} = ...
            @(L) hann(L, "periodic");

        % Number of segments generated in computation
        nSegments (1,1) {mustBeNonnegative} = 0
    end

    properties(Dependent, GetAccess = public)
        Nfft % Alias for the segment length
        numOverlapPts % Absolute overlap between the adjacent segments 
    end

    methods(Static, Access = public)
        % Computes Welc spectrum for arbitrary number of signals (sigs is
        % a repeating argument)
        varargout = of(sigs, options);
    end

    methods(Access = public)
        % Shows the spectrum using WelchSpectrumPlotter with default args
        plot(this, pltType)
    end

    methods(Access = private)
        % Implements spectrum computations for the constructor
        [pwr, phs, nSegm] = compute(this, s);
    end

    % Constructor
    methods(Access = public)
        % Use "of" method instead of the constructor
        % The constructor does not provide arguments validation,
        % autocompletetion hints and does not support repeating input
        % signals.
        function this = WelchSpectrum(varargin)
            
            if nargin == 0
                this = WelchSpectrum.of(Signal());
                return;
            else
                s = varargin{1};
                options = varargin{2};
            end

            % Calculate the segment length
            if options.SegmentLenghtMode == "Relative"
                assert(options.SegmentLenght > 0 && ...
                                            options.SegmentLenght <= 1,...
                    "WelchSpectrum:invalidArgument", ...
                    "Relative segment length must be 0..1.");

                this.segmentLength = round(s.n*options.SegmentLenght);                
            elseif options.SegmentLenght == "Absolute"
                assert(options.SegmentLenght == ...
                                        floor(options.SegmentLenght), ...
                    "WelchSpectrum:invalidArgument", ...
                    "Absolute segment length must be integer.");

                this.segmentLength = options.SegmentLenght;
            end

            this.relativeOverlap = options.Overlap;

            this.powTraceFuncName = options.PowTraceFunction;
            this.phsTraceFuncName = options.PhsTraceFunction;

            % Store spectral window generation function handle
            if options.Window == "custom"
                this.get_spwin = options.CustomWindow;
            else
                [~, this.get_spwin] = get_spectral_window( ...
                    options.Window, []);
            end

            this.Fs = s.Fs;
            this.description = s.description;
            if s.n > 0
                [this.power, this.phase, this.nSegments] = ...
                    this.compute(s);
                this.freqGrid = ...
                    ((-this.Nfft/2:this.Nfft/2-1)/this.Nfft*this.Fs)';
            end
        end
    end

    methods
        function val = get.numOverlapPts(this)
            val = floor(this.relativeOverlap*this.Nfft);
        end

        function val = get.Nfft(this)
            val = this.segmentLength;
        end
    end
end
