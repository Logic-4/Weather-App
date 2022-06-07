class Weather{
  final double temp;
  final double feelsLike;
  final double low;
  final double high;
  final String description;

  Weather({required this.temp, required this.feelsLike, required this.description, required this.high, required this.low});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feelsLike: json['main']['temp'].toDouble(),
      low: json['main']['temp'].toDouble(),
      high: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],

    );
  }
}
