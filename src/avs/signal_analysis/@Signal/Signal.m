classdef Signal
% SIGNAL Samples with associated sample rate and optional description
%
%   The class provides a container for assotiating a signal with its sample
%   rate. It defines basic numeric constants, arithmetic operations, and
%   other signal processing function.

    properties(SetAccess = public, GetAccess = public)
        % A row-vector with samples
        samples (1,:) {mustBeVector(samples, "allow-all-empties"), ...
            mustBeNumeric} = [];
        % Sample rate in Hz
        Fs {mustBeScalarOrEmpty, mustBePositive} = [];
        % Optional description, disregarded in comparisons
        description {mustBeTextScalar} = "";
    end

    properties(Dependent, GetAccess = public)
        n          % Number of samples
        Ts         % Sampling period, s
        t          % Time vector from 0 s
        re         % Alias for a vector with real part of each sample
        im         % Alias for a vector with imaginary part of each sample
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
        r = bsxfun(fun, a, b);
        this = from_struct(s)
        a = createArray(sz, args);
    end

    methods(Access = public)
        s = to_struct(this)

        varargout = plot(this, func, varargin)

        % Overloaded arithmetic operators
        a = plus(a, b);
        a = minus(a, b);
        a = uminus(a);
        a = times(a, b);
        a = rdivide(a, b);
        a = ldivide(a, b);
        a = power(a, b);
        r = ne(a, b);
        r = eq(a, b);
        a = conj(a);

        % Overloaded MATLAB functions
        a = abs(a);
        a = angle(a);
        r = sum(a, dim);
        r = rms(a);
        r = isreal(a);
        this = upsample(this, n, phase);
        this = downsample(this, n, phase);

        % Custom signal processing functions
        this = apply(this, func);
        this = filter_without_transient(this, b, options);
        this = clip(this, component, maxValue, minValue);
        [sre, sim] = split_re_im(this);
    end

    methods
        function val = get.n(this)
            val = length(this.samples);
        end

        function val = get.Ts(this)
            val = 1./this.Fs;
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
