classdef WelchSpectrumAnalyzer < matlab.mixin.Copyable
    % WelchSpectrumAnalyzer Computes Welch spectra
    %   This class computes Welch spectra of 'Signal' class objects.
    %   See also: SIGNAL, WELCHSPECTRUM, WELCHSPECTRUMPLOTTER

    properties
        % Absolute length of signal's segment used in computation
        SegmentLenghtAbsolute {mustBeScalarOrEmpty, ...
            mustBeInteger, mustBePositive} = [];
        % Length of signal's segment relative to its full length
        SegmentLengthRelative {mustBeScalarOrEmpty, ...
            mustBeInRange(SegmentLengthRelative, 0, 1, ...
            "exclude-lower")} = 0.5;

        % Overlab between two adjacent segments relative to segm. length
        Overlap (1,1) {mustBeInRange(Overlap, 0, 1, ...
            "exclude-upper")} = 0.5;

        % Function used to aggregate power spectra of segments
        PowTraceFunction {mustBeMember(PowTraceFunction, ...
            ["Average", "MaxHold", "MinHold"])} = ...
            "Average";
        % Function used to aggregate phase spectra of segments
        PhsTraceFunction {mustBeMember(PhsTraceFunction, ...
            ["Average", "MaxHold", "MinHold"])} = ...
            "Average";

        % Type of used spectral window
        %   chebwin, gausswin, kaiser, and tukeywin require a
        %   parameter. One must create them manually and pass as
        %   custom.
        Window ...
            {mustBeMember(Window, ...
                ["barthannwin" "bartlett" "blackman" ...
                "blackmanharris" "bohmanwin" "flattopwin" ...
                "hamming" "hann" "nuttallwin" "parzenwin" ...
                "rectwin" "triang" "custom"])} = ...
            "hann";
        % Function handle of custom spectral window function
        CustomWindow function_handle = ...
            @(p) assert(0);
    end

    methods
        % Compute Welch spectra of signals
        varargout = do(this, sigs);

        function this = WelchSpectrumAnalyzer(options)
            arguments(Input)
                options.?WelchSpectrumAnalyzer
            end

            MetaToolsForConstructor.assign_properties(this, options);
        end
    end

    methods(Static, Access = private)
        % Implements actual computation
        spec = compute_spectrum(sig, spec);
    end

end
