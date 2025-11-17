function idx = calc_indices_for_along_dim_operation(sz, dim)
% CALC_INDICES_FOR_ALONG_DIM_OPERATION Calc. idx for opeation along dim
%
%   IDX = CALC_INDICES_FOR_ALONG_DIM_OPERATION(SZ, DIM) prepares sets of
%   indices allowing to compute a function over array A
%       R = FUNC(A)
%   along dimension DIM avoiding unnecessery copies of elements.
%   SZ is size(A), and DIM is the target dimension of A.
%   The returned index array has the following properties:
%       - size(IDX) == size(R)
%       - R(i) = FUNC( A(IDX(i)) ).
%
%   For speed, the functions does not perform any checks.
% 
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

nDims = length(sz);
nElems = prod(sz);
numElemsInDim = sz(dim);

linearInpIdx = 1:nElems;
linInpIdxMap = reshape(linearInpIdx, sz);

mapWithDimFirst = permute(linInpIdxMap, [dim, 1:dim-1 dim+1:nDims]);

resultSize = sz;
resultSize(dim) = 1;

idx = cell(resultSize);

for i = 1:numel(idx)
    idx_i = numElemsInDim*(i-1)+1:numElemsInDim*i;
    idx{i} = mapWithDimFirst(idx_i);
end

end
