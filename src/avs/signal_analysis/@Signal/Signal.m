classdef Signal
% SIGNAL A class combining samples with sample rate and optional note
%
%   The class provides a container for assotiating a signal with its sample
%   rate. It also defines the basic arithmetic operations for singlas and
%   numeric constants.

    properties(SetAccess = public, GetAccess = public)
        % A row-vector with Signal's samples
        samples (1,:) {mustBeVector(samples, "allow-all-empties"), ...
            mustBeNumeric} = [];
        % Sample rate
        Fs {mustBeScalarOrEmpty, mustBePositive} = [];
        % Optional, disregarded in comparisons.
        description {mustBeTextScalar} = "";
    end

    properties(Dependent, GetAccess = public)
        n          % Number of samples
        Ts         % Sampling period, s
        isComplex  % True if the samples are complex-valued
        t          % Time vector from 0 s for convenience of plotting
        re         % Alias for a vector with real part of each sample
        im         % Alias for a vector with  imaginary part of each sample
    end

    methods(Access = public)
        function this = Signal(samples, Fs, description)
            arguments(Input)
                samples = [];
                Fs = [];
                description = "";
            end

            this.samples = samples;
            this.Fs = Fs;
            this.description = description;
        end
    end

    methods(Static, Access = public)
        % Create an object from a structure
        this = from_struct(s)
    end

    methods(Access = public)
        % Convert an object to a structure
        s = to_struct(this)

        % Plot the specified Signal's component (re or im)
        varargout = plot(this, component, varargin)

        % Compute Welch spectrum of the signal
        sp = welch(this, segmLengthOrAnalyzer)
    end

    methods(Access = public)
        % Overloading of MATLAB basic operators
        r = plus(a, b);
        r = minus(a, b);
        r = uminus(a);
        r = times(a, b);
        r = rdivide(a, b);
        r = ldivide(a, b);
        r = power(a, b);
        r = ne(a, b);
        r = eq(a, b);
        r = conj(a);
        
        % Other signal processing functions
        r = upsample(this, n, phase);
        r = downsample(this, n, phase);
        r = filter_without_transient(this, b, options);
    end

    methods(Access = public, Static)
        r = sum(a);
    end

    methods
        function val = get.n(this)
            val = length(this.samples);
        end

        function val = get.Ts(this)
            val = 1./this.Fs;
        end

        function val = get.isComplex(this)
            val = ~isreal(this.samples);
        end

        function val = get.t(this)
            val = (0:this.n-1)*this.Ts;
        end

        function val = get.re(this)
            val = real(this.samples);
        end

        function val = get.im(this)
            val = imag(this.samples);
        end
    end

end
