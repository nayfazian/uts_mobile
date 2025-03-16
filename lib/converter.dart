class TemperatureConverter {
  static double convert(double value, String conversionType) {
    switch (conversionType) {
      case 'Celsius ke Fahrenheit':
        return (value * 9 / 5) + 32;
      case 'Fahrenheit ke Celsius':
        return (value - 32) * 5 / 9;
      case 'Celsius ke Kelvin':
        return value + 273.15;
      case 'Kelvin ke Celsius':
        return value - 273.15;
      default:
        return value;
    }
  }
}
