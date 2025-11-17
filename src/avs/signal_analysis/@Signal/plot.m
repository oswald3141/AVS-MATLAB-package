function varargout = plot(this, func, varargin)
% PLOT Plot a Signal's component (re or im)
%
%   PLOT(THIS, FUNC, ARG1, ARG2, ..., ARGN) plots samples of THIS appplying
%   FUNC and using the  time vector THIS.t. By default, plots the real part
%   of THIS (FUNC is set to @real).
%
%   Uses buil-in "plot" function and passes all the additional arguments to
%   it directly in the same order. An exception is made only if ARG1 is an
%   axes object, in which case it is passeed to "plot" as a first argument
%   to satisfy its syntax.
%
%   P = PLOT(...) returnes the line object.

arguments(Input)
    this (1,1) Signal
    func (1,1) {mustBeA(func, "function_handle")} = @real;
end

arguments(Input, Repeating)
    varargin
end

ax = gca();
if (nargin > 2) && isa(varargin{1}, "matlab.graphics.axis.Axes")
    ax = varargin{1};
    varargin(1) = [];
end

if nargout == 1
    varargout{1} = plot(ax, this.t, func(this.samples), varargin{:});
else
    plot(ax, this.t, func(this.samples), varargin{:});
end

end
