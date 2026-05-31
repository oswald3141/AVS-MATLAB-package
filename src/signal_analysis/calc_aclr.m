function aclr = calc_aclr(pwr, freq, mainChCenter, chWidth, guardBw, chann)
% CALC_ACLR Calculate ACLR from a power spectrum
%
%   ACLR = CALC_ACLR(PWR, FREQ, MAINCHCENTER, CHWIDTH) takes a signal's
%   power spectrum (frequencies in FREQ and the corresponding power levels
%   in PWR), center frequency of the main channel (MAINCHCENTER), and the
%   channel's width (CHWIDTH) and calculates the maximum ACLR for all the
%   channels except the main one.
%   All frequencies must be in the same units (e.g. Hz). FREQ must cover at
%   least the main channel and the two adjacent ones.
%   The calculation is performed as required by 6.5.2.4 of 3GPP TS 38.101
%   assuming zero guard bandwidth.
%
%   ACLR = CALC_ACLR(..., GUARDBW) also sets the guard bands widths. The
%   power in these bands is disregarded both for the main and adjacent
%   channels. GUARDBW - is the bandwidth that will be left out from both
%   (left and right) edges of each chanel. For example, if it is set to 5
%   MHz, 10 MHz in total will be left out in each channel.
%
%   ACLR = CALC_ACLR(..., GUARDBW, CHANN) allows to choose a channel for
%   which the ACLR is calculated. CHANN can be:
%       - "max" (default) - the maximum ACLR among all the channels fitted
%       into FREQ.
%       - "all" - ACLR values for all channels fitted into FREQ (ACLR is
%       array).
%       - integer numbers - ACLR for the channels with specified numbers
%       (e.g. 1, -1, -10, 12). The required channels must be present in
%       FREQ. ACLR is an array in this case.
%
%   See also: CALC_EVM_RMS

arguments(Input)
    pwr  {mustBeVector, mustBeNonnegative}
    freq {mustBeVector, mustBeReal, mustHaveSameSize(freq,pwr)}
    mainChCenter (1,1) {mustBeReal}
    chWidth  (1,1) {mustBeReal, mustBeNonnegative}
    guardBw  (1,1) {mustBeReal, mustBeNonnegative} = 0.0;
    chann = "max";
end

freq = freq(:)';
fStart = freq(1);
fEnd = freq(end);

mainChBounds = [...
    mainChCenter - chWidth/2 ...
    mainChCenter + chWidth/2]';

nLeftCh  = floor((mainChBounds(1) - fStart + guardBw)/chWidth);
nRightCh = floor((fEnd - mainChBounds(2) + guardBw)/chWidth);

allChNums = [-nLeftCh:-1 0 1:nRightCh];

if isreal(chann)
    assert(all(chann == unique(chann)), ...
        "calc_aclr:nonuniqueChannelNumbers", ...
        "The array with the requested channel numbers must not " + ...
            "contain repeated values.");
    selChNums = chann(ismember(chann, allChNums));
elseif isstring(chann) && isscalar(chann)
    assert(ismember(chann, ["all" "max"]), ...
        "calc_aclr:unknownChannels", ...
        "Unexpected requested channels definition.");
    if chann == "all"
        selChNums = allChNums;
    elseif chann == "max"
        selChNums = allChNums;
        selChNums(selChNums==0) = [];
    end
end

chCenterFreqs = mainChCenter + selChNums*chWidth;
chAvgPwrs = [];
for iCh = length(chCenterFreqs):-1:1
    chAvgPwrs(iCh) = calc_ch_avg_pwr(chCenterFreqs(iCh));
end

mainChAvgPwr = calc_ch_avg_pwr(mainChCenter);

selAclr = pow2db(chAvgPwrs/mainChAvgPwr);

if isstring(chann) && (chann == "max")
    aclr = max(selAclr);
elseif isstring(chann) && (chann == "all")
    aclr = selAclr;
else
    aclr = NaN*ones(size(chann));
    [~, ind] = find((chann == selChNums'));
    aclr(ind) = selAclr;
end

    function chAvgPwr = calc_ch_avg_pwr(chCenterFreq)
        chBounds = [
            chCenterFreq - chWidth/2 + guardBw
            chCenterFreq + chWidth/2 - guardBw];
        [~, iChBounds] = min(abs(freq - chBounds ), [], 2);
        chPwrs = pwr(iChBounds(1) : iChBounds(2));
        chAvgPwr = mean(chPwrs);
    end

end
