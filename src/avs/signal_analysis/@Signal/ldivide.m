function r = ldivide(a, b)
% LDIVIDE Divides signal with another signal or a numeric value
%
%    R = LDIVIDE(A, B) divides B by A if one of them is Signal and the
%    other one is either Signal or a numeric value. Performs dimensions
%    expansion if necessary.
%    R inherits "description" property of A unless it is numeric. In such a
%    case the property of B is inherited.
%    This call also represents overloaded "left divide" operator, so it
%    can be performed as
%       R = A.\B;

r = apply_basic_bin_op(a, b, @ldivide);

end
