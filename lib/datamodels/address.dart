class Address {
  final String placeName;
  final double latitude;
  final double longitude;
  final String placeId;
  final String placeFormattedAddress;

  Address({
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.placeId,
    required this.placeFormattedAddress,
  });

  factory Address.initial() {
    return Address(
      placeName: '',
      latitude: 0.0,
      longitude: 0.0,
      placeId: '',
      placeFormattedAddress: '',
    );
  }
}
