function p = closest_mult(v, n, mode)
% CLOSEST_MULT Return closest multiple of the given number
%
%   P = CLOSEST_MULT(V, N) returns a multiple of N closest to V.
%
%   P = CLOSEST_MULT(V, N, MODE) specifies the direction of the multiple
%   roulding. If MODE is set to "floor" the function will return the
%   closest multiple of N less than V. If MODE is set to "ceil" the closest
%   multiple of N more than V will be returned. And, if MODE is set to
%   "round" a multiple of N closest to V will be returned.
%   The default value of MODE is "round".

arguments(Input)
    v {mustBeReal}
    n (1,1) {mustBeReal}
    mode {mustBeMember(mode, ["round", "ceil", "floor"])} = "round"
end

switch mode
    case "round"
        p = n*round(v/n);
    case "ceil"
        p = n*ceil(v/n);
    case "floor"
        p = n*floor(v/n);
end

end
