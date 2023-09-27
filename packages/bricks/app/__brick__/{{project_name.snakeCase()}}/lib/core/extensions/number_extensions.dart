import 'dart:math';

/// Rounds to a certain number of decimal places
extension RoundToPrecision on double {
  double roundToPrecision(double precision) {
    final num mod = pow(10, precision);

    return (this * mod).round().toDouble() / mod;
  }
}
