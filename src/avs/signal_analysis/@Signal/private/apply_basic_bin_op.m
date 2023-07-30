function r = apply_basic_bin_op(a, b, op)
% APPLY_BASIC_BIN_OP Apply basic binary operation
%
%     Handles types variations and ensures arrays compatibility.

if ~isa(a, "Signal")
    [a, b] = swap(a, b);
end

bIsSig = isa(b, "Signal"); % Inctrospection is expensive, cache result

try
    assert(bIsSig || isnumeric(b), ...
        "Signal:operandsMustBeSignalOrNumeric", ...
        "The operand's type is neither numeric nor Signal.");

    aN = numel(a);
    bN = numel(b);

    if aN > 1 && bN > 1 % Do array expansion if needed
        [a, b] = equalize_sizes(a, b);
    end

    if bIsSig % Fewer cond in the main cycle (speed)
        assert(all([a.Fs] == [b.Fs], "all"), ...
            "Signal:samplingRatesMustMatch", ...
            "Arithmetic operations on signals with different " + ...
                "sampling rates are not possible.")
        opx = @opSig;
    else
        opx = @opNum;
    end
    
    if aN == 1
        for i = bN:-1:1
            r(i) = opx(a, b(i), op);
        end
        r = reshape(r, size(b));
    elseif bN == 1
        r = a;
        for i = aN:-1:1
            r(i) = opx(a(i), b, op);
        end
    else
        for i = aN:-1:1
            r(i) = opx(a(i), b(i), op);
        end
        r = reshape(r, size(a));
    end

catch ME
    switch (ME.identifier)
        case "MATLAB:sizeDimensionsMustMatch"
            throwAsCaller(MException("Signal:lengthsMustMatch", ...
                "Arithmetic operations on signals with different " + ...
                    "lengths are not possible."));
        case "equalize_sizes:sizeDimensionsMustMatch"
            throwAsCaller(MException("Signal:sizeDimensionsMustMatch", ...
                "Arrays have incompatible sizes for this operation."));
        otherwise
            throwAsCaller(ME);
    end
end

    function r = opSig(a, b, op)
        r = Signal(op(a.samples, b.samples), a.Fs, a.description);
    end

    function r = opNum(a, b, op)   
        r = Signal(op(a.samples, b), a.Fs, a.description);
    end

end
