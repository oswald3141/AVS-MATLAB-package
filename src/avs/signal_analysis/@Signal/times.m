function r = times(a, b)
% TIMES Multiplies signal with another signal or a numeric value
%
%    R = TIMES(A, B) multiplies A with B if one of them is Signal and the
%    other one is either Signal or a numeric value. Performs dimensions
%    expansion if necessary.
%    R inherits "description" property of A unless it is numeric. In such a
%    case the property of B is inherited.
%    This call also represents overloaded "times" operator, so it can be
%    performed as
%       R = A.*B;

r = apply_basic_bin_op(a, b, @times);

end
