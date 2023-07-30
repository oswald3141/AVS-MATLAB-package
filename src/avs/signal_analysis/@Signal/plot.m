function varargout = plot(this, component, varargin)
% PLOT Plot a Signal's component (re or im)
%
%   PLOT(THIS, COMPONENT, ARG1, ARG2, ..., ARGN) plots real (if COMPONENT
%   is set to "re") or imaginary (if COMPONENT is set to "im") component of
%   THIS using the time vector from this object (THIS.t).
%   By default plots the real part.
%   Uses buil-in "plot" function and passes all the additional arguments to
%   it directly in the same order. Makes exception only if ARG1 is an axes
%   object. In such a case passes it as a first argument to MATLAB's "plot"
%   to satisfy its syntax.
%
%   P = PLOT(...) returnes the line object.

arguments(Input)
    this (1,1) Signal
    component {mustBeMember(component, ["re" "im"])} = ...
        "re";
end

arguments(Input, Repeating)
    varargin
end

ax = gca();
if (nargin > 2) && isa(varargin{1}, "matlab.graphics.axis.Axes")
    ax = varargin{1};
    varargin(1) = [];
end

switch (component)
    case "re"
        p = ...
            plot(ax, this.t, real(this.samples), varargin{:});
    case "im"
        p = ...
            plot(ax, this.t, imag(this.samples), varargin{:});
    otherwise
        assert(0);
end

if nargout == 1
    varargout{1} = p;
end

end
