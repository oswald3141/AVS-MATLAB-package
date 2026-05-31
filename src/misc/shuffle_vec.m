function v = shuffle_vec(v)
% SHUFFLE_VEC Randomly rearrange elements of a vector
%
%   V = SHUFFLE_VEC(V) returns the same vector with its elements rearranged
%   randomly.

arguments
    v {mustBeVector}
end

v = v(randperm(length(v)));

end
