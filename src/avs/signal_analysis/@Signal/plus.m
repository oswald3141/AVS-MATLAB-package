function r = plus(a, b)
% PLUS Adds signal to another signal or a numeric value
%
%    R = PLUS(A, B) adds A to B if one of them is Signal and the
%    other one is either Signal or a numeric value. Performs dimensions
%    expansion if necessary.
%    R inherits "description" property of A unless it is numeric. In such a
%    case the property of B is inherited.
%    This call also represents overloaded "plus" operator, so it can be
%    performed as
%       R = A + B;

r = apply_basic_bin_op(a, b, @plus);

end
