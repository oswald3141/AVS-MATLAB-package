function a = plus_sig_sig(a, b)
check_arith_bin_op_compatibility(a, b);
a.samples = a.samples + b.samples;
end
