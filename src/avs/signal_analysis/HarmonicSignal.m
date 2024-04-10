classdef HarmonicSignal < Signal

    properties(GetAccess = public, SetAccess = public)
        fc {mustBeScalarOrEmpty, mustBeNonnegative} = 0;
    end

    properties(Dependent, GetAccess = public)
        signal (1,1) {mustBeUnderlyingType(signal, "Signal")}
    end

    methods(Access = public)
        function this = HarmonicSignal(A, fc, phi0, N, Fs, description)
            arguments(Input)
                A    {mustBeScalarOrEmpty, mustBeNonnegative} = [];
                fc   {mustBeScalarOrEmpty, mustBeNonnegative} = [];
                phi0 {mustBeScalarOrEmpty, mustBeReal} = [];
                N    {mustBeScalarOrEmpty, mustBeInteger, ...
                                            mustBeNonnegative} = [];
                Fs   {mustBeScalarOrEmpty, mustBePositive} = [];
                description {mustBeTextScalar} = "";
            end

            t = (0:N-1).*(1./Fs);
            s = A.*exp(1j*2*pi*fc*t + phi0);
            
            this@Signal(s, Fs, description);
            this.fc= fc;
        end
    end

    methods
        function s = get.signal(this)
            s = Signal(this.samples, this.Fs, this.description);
        end
    end

end
