function [aIdx, bIdx] = calc_indices_for_bsx(aSize, bSize)
% CALC_INDICES_FOR_BSX Calculate indicies for binary singleton expansion
%
%   [AIDX, BIDX] = CALC_INDICES_FOR_BSX(ASIZE, BSIZE) prepares sets of
%   indicies allowing to compute an element-wise binary operation
%       R = binary_operation(A, B)
%   with implicit expansion of singleton dimensions and avoiding
%   unnecessery copies of elements of A and B.
%   ASIZE, BSIZE are size(A) and size(B) respectively.
%   The returned index arrays have the following properties:
%       - size(AIDX) == size(BIDX) == size(R)
%       - R(i) = binary_operation(A(AIDX(i)), B(BIDX(i)),
%           where i is the liear index of the result array R.
%
%   For speed, the functions does not perform any checks.
% 
%   The code is distributed under The MIT License
%   Copyright (c) 2025 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

% Equalize size vectors adding trailing 1
maxDimNum = max(length(aSize), length(bSize));
aSize(end+1:maxDimNum) = 1;
bSize(end+1:maxDimNum) = 1;

% Locate singleton dimensions
singletonIdxA = (aSize == 1);
singletonIdxB = (bSize == 1);

% Determine repetition factors for each dimension
nRepeatDimA = ones(size(aSize));
nRepeatDimA(singletonIdxA) = bSize(singletonIdxA);
nRepeatDimB = ones(size(bSize));
nRepeatDimB(singletonIdxB) = aSize(singletonIdxB);

% Calculate combinations of elements from A and B forming the result
numelA = prod(aSize);
numelB = prod(bSize);

linearIdxA = 1:numelA;
linearIdxB = 1:numelB;

idxForResultA0 = reshape(linearIdxA, aSize);
idxForResultB0 = reshape(linearIdxB, bSize);

% Do the singleton expansion
aIdx = repmat(idxForResultA0, nRepeatDimA);
bIdx = repmat(idxForResultB0, nRepeatDimB);

end
