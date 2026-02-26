function r = isreal(a, eachstr)
% ISREAL Determine whether signal uses complex storage
%
%   R = ISREAL(A) returns "true" if all signals in A are real, and "false"
%   if at least one of them is complex. Behaves the same way as MATLAB's
%   isreal().
%
%   R = ISREAL(A, "each") returns a logical array of the same size as A. An
%   element in R is "true" if the corresponding signal in A is real, and
%   "false" otherwise.
%
%   The code is distributed under The MIT License
%   Copyright (c) 2026 Andrei Smoliakov
%       (main 'at' avsm 'punto' me)
%   See LICENSE for the complete license text

arguments
    a Signal
end

arguments(Repeating)
    eachstr (1,1) {mustBeMember(eachstr, "each")}
end

assert(length(eachstr) <= 1, "AVS:maxrhs", "Too many input arguments.");

if isempty(eachstr)
    r = true;
    for i = 1:numel(a)
        if ~isreal(a(i).samples)
            r = false;
            break;
        end
    end
else
    r = zeros(size(a), "logical");
    for i = 1:numel(a)
        r(i) = isreal(a(i).samples);
    end
end

end
