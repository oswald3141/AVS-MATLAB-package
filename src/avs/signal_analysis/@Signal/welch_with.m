function varargout = welch_with(this, analyzer)

arguments
    this
    analyzer (1,1) WelchSpectrumAnalyzer
end

varargout{:} = analyzer.compute_spectrum(this);

end