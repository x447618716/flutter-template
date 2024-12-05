class Coordinate {
  Coordinate({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Coordinate otherCoordinate = other as Coordinate;
    return otherCoordinate.latitude == latitude &&
        otherCoordinate.longitude == longitude;
  }

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

}
