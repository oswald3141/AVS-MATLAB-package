# Additional Validators
Additional argument and property validation functions
currently absent in MATLAB's standard library.

# Content
- `mustHaveSameSize` validates that values have the same size.
- `mustBeBinary` validates that a value is binary.
- `mustBeDecreasing` validates that values in a vector are decreasing.
- `mustBeIncreasing` validates that values in a vector are increasing.
- `mustBeEven` validates that a value is even.
- `mustBeOdd` validates that a value is odd.
- `mustHaveCompatibleSizes` validates that values have compatible sizes.
- `mustBeObject` validates that a value is an object of a MATLAB class.
- `mustHaveSameKeysAndTypes` validates that dictionaries have same types and keys.
- `mustBeEvenPowerOfTwo` validates that a value is an even power of 2.
- `mustBeNaturalPowerOfTwo` validates that a value is a natural power of 2.
- `mustBeAngleInQuadrant` validates that a value is an angle from a quadrant.
- `mustBeAngleWrappedTo` validates that a value is an angle wrapped to a value.
- `mustBeAxisLimits` validates that an input defines axis limits.

## Dependencies
The code is tested in MATLAB R2025b, but should work in some older versions as well.
