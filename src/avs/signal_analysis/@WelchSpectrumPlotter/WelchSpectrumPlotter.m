classdef WelchSpectrumPlotter < matlab.mixin.Copyable
% WELCHSPECTRUMPLOTTER Plots Welch spectra
%
%   This class allows to set up the plotter once and show spectra with the
%   same plotting prameters. It supports plotting several spectra in the
%   same axis.
%
%   See also: WELCHSPECTRUM, WELCHSPECTRUMANALYZER

    properties(SetAccess = public, GetAccess = public)
        % Type of the plot (magnitude, phase or both)
        PlotType {mustBeMember(PlotType, ...
            ["Magnitude", "Phase", "Magn&Phase"])} = "Magnitude"

        % Type of the magnitude plot (amplitude or power)
        PlotMagnType {mustBeMember(PlotMagnType, ...
            ["Amplitude", "Power"])} = "Power"
        % Magnitude units (linear of dB)
        PlotMagnUnits {mustBeMember(PlotMagnUnits, ...
            ["Linear", "Decibels"])} = "Decibels"
        % Controls if the magnitude is normalized before plotting
        PlotNormalizeMagn {mustBeMember(PlotNormalizeMagn, ...
            ["yes", "no"])} = "yes"

        % Phase units (degrees or radians)
        PlotPhsUnits {mustBeMember(PlotPhsUnits, ...
            ["Radians", "Degrees"])} = "Radians"

        % Width of the lines on the plot
        LinesWidth (1,1) {mustBePositive} = 1.0
        % Grid on the plot (on, off, minor)
        GridMode {mustBeMember(GridMode, ...
            ["on", "off", "minor"])} = "on"

        % Magnitude axes limits
        MagnYLim {mustBeAxisLimits} = "auto"
        % Phase axes limits
        PhsYLim {mustBeAxisLimits} = "auto"
        % Frequency axes limits
        XLim {mustBeAxisLimits} = "auto"

        % Legend location. Directly passed to MATLAB's "legend".
        LegendLocation {mustBeTextScalar} = "northeast"
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
                options.?WelchSpectrumPlotter
            end

            MetaToolsForConstructor.assign_properties(this, options);
        end
    end

    methods(Access = private)
        [fScale, fUnits] = get_spectrum_freq_axis_params(~,Fs);
    end

end
