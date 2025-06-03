function colorarray = colorblind_friendly_palette()
% COLORBLIND_FRIENDLY_PALETTE Return the colorblind-friendly palette
%
%   COLORARRAY = COLORBLIND_FRIENDLY_PALETTE() returns a color palette, in
%   which colors are distinguishable for people with normal vision and for
%   people with color blindness (protan, deutan, tritan).
%   Refer to https://jfly.uni-koeln.de/color/ for the details.

colorarray = [
    "#0072B2" % Blue
    "#D55E00" % Vermilion
    "#E69F00" % Orange
    "#CC79A7" % Reddish purple
    "#009E73" % Bluish green
    "#56B4E9" % Sky blue
    "#000000" % Black
    "#F0E442" % Yellow
];

end
