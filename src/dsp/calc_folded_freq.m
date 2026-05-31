function ff = calc_folded_freq(f, Fs)
% CALC_FOLDED_FREQ Calculate frequency after aliasing
%
%   FF = CALC_FOLDED_FREQ(F, FS) calculates the positions of
%   frequencies F after aliasing with sampling frequency FS.

arguments
    f  (1,:) {mustBeNonnegative}
    Fs (:,1) {mustBePositive}
end

NyqF = Fs/2;
NyqZ = ceil(f./NyqF);

ff = repmat(f, length(Fs), 1);
idx = mod(NyqZ,2) == 0;
c = (NyqZ - 0).*NyqF;
ff(idx) = -ff(idx) + c(idx);
idx = mod(NyqZ,2) == 1;
c = (NyqZ - 1).*NyqF;
ff(idx) = +ff(idx) - c(idx);

end
