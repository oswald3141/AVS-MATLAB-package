function varargout = welch(this, segmLength)

arguments
    this
    segmLength (1,1) {mustBePositive} = 0.5;
end

analyzer = WelchSpectrumAnalyzer("SegmentLenght", segmLength);
varargout{:} = this.welch_with(analyzer);

end