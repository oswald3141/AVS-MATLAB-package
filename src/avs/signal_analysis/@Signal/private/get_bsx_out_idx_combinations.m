function [aIdx, bIdx] = get_bsx_out_idx_combinations(as, bs)
% GET_BSX_OUT_IDX_COMBINATIONS Calc order for bsxfun
%
%   [AIDX, BIDX] = GET_BSX_OUT_IDX_COMBINATIONS(AS, BS) calculates indicies
%   AIDX and BIDX such that C = 

ml = max(length(as), length(bs));
as(end+1:ml) = 1;
bs(end+1:ml) = 1;

as1 = as == 1;
bs1 = bs == 1;
ar = ones(size(as));
br = ar;
ar(as1) = bs(as1);
br(bs1) = as(bs1);

aIdx0 = reshape(1:prod(as), as);
bIdx0 = reshape(1:prod(bs), bs);

aIdx = repmat(aIdx0, ar);
bIdx = repmat(bIdx0, br);

end
