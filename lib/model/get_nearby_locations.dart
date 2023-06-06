import 'package:living_labs_maps_api/model/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.
class NearbyLocationGet {
  final String id;
  final String locationCoordinate;
  final double haversineDistance;
  final List category;
  final String placeId;
  final String placeName;

  const NearbyLocationGet({
    required this.id,
    required this.locationCoordinate,
    required this.haversineDistance,
    required this.category,
    required this.placeId,
    required this.placeName,
  });

  Map<String, dynamic> toJson() => {
        Constants.id: id,
        Constants.locationCoordinates: locationCoordinate,
        Constants.haversineDistance: haversineDistance,
        Constants.category: category,
        Constants.placeId: placeId,
        Constants.placeName: placeName,
      };

  factory NearbyLocationGet.fromJson(
    Map<String, dynamic> json,
  ) {
    return NearbyLocationGet(
      id: json[Constants.id],
      locationCoordinate: json[Constants.locationCoordinates],
      haversineDistance: json[Constants.haversineDistance],
      category: json[Constants.category],
      placeId: json[Constants.placeId],
      placeName: json[Constants.placeName],
    );
  }
}
