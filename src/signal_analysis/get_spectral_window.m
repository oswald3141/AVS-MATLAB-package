function [w, f] = get_spectral_window(name, L, p)
% GET_SPECTRAL_WINDOW Return the required spectral window
%   [W, F] = GET_SPECTRAL_WINDOW(NAME, L, P) returnes a vector W containing
%   L-points spectral window of "NAME" type and a handle F of a function
%   generating NAME window of arbitrary length.
%   P is an additional parameter required for chebwin, gausswin, kaiser,
%   and tukeywin functions. For other windows you must omit it.
%   The function return periodic window whenever possible.

arguments(Input)
    name {mustBeMember(name, ...
        ["barthannwin" "bartlett" "blackman" "blackmanharris" ...
        "bohmanwin" "chebwin" "flattopwin" "gausswin" "hamming" ...
        "hann" "kaiser" "nuttallwin" "parzenwin" "rectwin" ...
        "tukeywin" "triang" "custom"])}
    L {mustBeScalarOrEmpty, mustBeInteger, mustBeNonnegative}
    p {mustBeScalarOrEmpty, mustBePositive} = [];
end

if (name == "chebwin") || (name == "gausswin") || ...
                                (name == "kaiser") || (name == "tukeywin")
    assert(~isempty(p), ...
        "get_spectral_window:parameterRequired", ...
        "The requested window requires an additional parameter");
else
    assert(isempty(p), ...
        "get_spectral_window:parameterIsNotRequired", ...
        "The requested window requires no additional parameters");
end

switch name
    case "barthannwin"
        w = barthannwin(L);
        f = @(L) barthannwin(L);
    case "bartlett"
        w = bartlett(L);
        f = @(L) bartlett(L);
    case "blackman"
        w = blackman(L, "periodic");
        f = @(L) blackman(L, "periodic");
    case "blackmanharris"
        w = blackmanharris(L, "periodic");
        f = @(L) blackmanharris(L, "periodic");
    case "bohmanwin"
        w = bohmanwin(L);
        f = @(L) bohmanwin(L);
    case "chebwin"
        w = chebwin(L, p);
        f = @(L) chebwin(L, p);
    case "flattopwin"
        w = flattopwin(L, "periodic");
        f = @(L) flattopwin(L, "periodic");
    case "gausswin"
        w = gausswin(L, p);
        f = @(L) gausswin(L, p);
    case "hamming"
        w = hamming(L, "periodic");
        f = @(L) hamming(L, "periodic");
    case "hann"
        w = hann(L,"periodic");
        f = @(L) hann(L, "periodic");
    case "kaiser"
        w = kaiser(L, p);
        f = @(L) kaiser(L, p);
    case "nuttallwin"
        w = nuttallwin(L, "periodic");
        f = @(L) nuttallwin(L, "periodic");
    case "parzenwin"
        w = parzenwin(L);
        f = @(L) parzenwin(L);
    case "rectwin"
        w = rectwin(L);
        f = @(L) rectwin(L);
    case "tukeywin"
        w = tukeywin(L, p);
        f = @(L) tukeywin(L, p);
    case "triang"
        w = triang(L);
        f = @(L) triang(L);
end

end
