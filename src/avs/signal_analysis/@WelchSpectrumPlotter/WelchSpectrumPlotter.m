classdef WelchSpectrumPlotter
% WELCHSPECTRUMPLOTTER Plots Welch spectra
%
%   This class allows to set up the plotter once and show spectra with the
%   same plotting prameters. It supports plotting several spectra in the
%   same axis.
%
%   See also: WELCHSPECTRUM, WELCHSPECTRUMANALYZER

    properties(SetAccess = public, GetAccess = public)
        % Type of the plot (magnitude, phase or both)
        plotType {mustBeMember(plotType, ...
            ["Magnitude", "Phase", "Magn&Phase"])} = "Magnitude"

        % Type of the magnitude plot (amplitude or power)
        plotMagnType {mustBeMember(plotMagnType, ...
            ["Amplitude", "Power"])} = "Power"
        % Magnitude units (linear of dB)
        plotMagnUnits {mustBeMember(plotMagnUnits, ...
            ["Linear", "Decibels"])} = "Decibels"
        % Controls if the magnitude is normalized before plotting
        plotNormalizeMagn {mustBeMember(plotNormalizeMagn, ...
            ["yes", "no"])} = "yes"

        % Phase units (degrees or radians)
        plotPhsUnits {mustBeMember(plotPhsUnits, ...
            ["Radians", "Degrees"])} = "Radians"

        % Width of the lines on the plot
        linesWidth (1,1) {mustBePositive} = 1.0
        % Grid on the plot (on, off, minor)
        gridMode {mustBeMember(gridMode, ...
            ["on", "off", "minor"])} = "on"

        % Magnitude axes limits
        magnYLim {mustBeAxisLimits} = "auto"
        % Phase axes limits
        phsYLim {mustBeAxisLimits} = "auto"
        % Frequency axes limits
        xLim {mustBeAxisLimits} = "auto"

        % Legend location. Directly passed to MATLAB's "legend".
        legendLocation {mustBeTextScalar} = "northeast"
    end

    methods(Access = public)
        % Shows spectrum or several of them in the same axes. Uses the
        % parameters form this class, accepts only the legend entries names
        % in "options".
        show(this, sp, options);
    end

    methods(Access = public)
        % The construcot just stores the passed named arguments' values
        % into the object's properties. It does not process them in any
        % way.
        function this = WelchSpectrumPlotter(options)
            arguments(Input)
                options.PlotType ...
                    {mustBeMember(options.PlotType, ...
                        ["Magnitude", "Phase", ...
                        "Magn&Phase"])} = ...
                    "Magnitude";

                options.PlotMagnType ...
                    {mustBeMember(options.PlotMagnType, ...
                        ["Amplitude", "Power"])} = ...
                    "Power";
                options.PlotMagnUnits ...
                    {mustBeMember(options.PlotMagnUnits, ...
                        ["Linear", "Decibels"])} = ...
                    "Decibels";
                options.PlotNormalizeMagn ...
                    {mustBeMember(options.PlotNormalizeMagn, ...
                        ["yes", "no"])} = ...
                    "yes";

                options.PlotPhsUnits ...
                    {mustBeMember(options.PlotPhsUnits, ...
                        ["Radians", "Degrees"])} = ...
                    "Radians";

                options.LinesWidth (1,1) ...
                    {mustBePositive} = ...
                    1.0;
                options.GridMode ...
                    {mustBeMember(options.GridMode, ...
                        ["on", "off", "minor"])} = ...
                    "on";

                options.MagnYLim ...
                    {mustBeAxisLimits} = ...
                    "auto";
                options.PhsYLim ...
                    {mustBeAxisLimits} = ...
                    "auto";
                options.XLim ...
                    {mustBeAxisLimits} = ...
                    "auto";

                 options.LegendLocation ...
                     {mustBeTextScalar} = ...
                     "northeast";
            end

            this.plotType = options.PlotType;

            this.plotMagnType = options.PlotMagnType;
            this.plotMagnUnits = options.PlotMagnUnits;
            this.plotNormalizeMagn = options.PlotNormalizeMagn;

            this.plotPhsUnits = options.PlotPhsUnits;

            this.linesWidth = options.LinesWidth;
            this.gridMode = options.GridMode;

            this.magnYLim = options.MagnYLim;
            this.phsYLim = options.PhsYLim;
            this.xLim = options.XLim;

            this.legendLocation = options.LegendLocation;
        end
    end

    methods(Access = private)
        [fScale, fUnits] = get_spectrum_freq_axis_params(~,Fs);
    end

end
