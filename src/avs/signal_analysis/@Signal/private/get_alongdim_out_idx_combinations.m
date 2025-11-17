function outIdxCombs = get_alongdim_out_idx_combinations(sz, dim)

nDims = length(sz);
nElems = prod(sz);
dimNumElems = sz(dim);

idxInp = reshape(1:nElems, sz);
idx1 = permute(idxInp, [dim, 1:dim-1 dim+1:nDims]);

resSize = sz;
resSize(dim) = 1;

outIdxCombs = cell(resSize);
for i = 1:numel(outIdxCombs)
    idx_i = dimNumElems*(i-1)+1:dimNumElems*i;
    outIdxCombs{i} = idx1(idx_i);
end

end
