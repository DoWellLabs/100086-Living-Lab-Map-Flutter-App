import 'package:living_labs_maps_api/model/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.
class NearbyLocationPost {
  final int radiusOne;
  final int radiusTwo;
  final double centerLat;
  final double centerLon;
  final String queryString;
  final String dataType;

  const NearbyLocationPost({
    required this.radiusOne,
    required this.radiusTwo,
    required this.centerLat,
    required this.centerLon,
    required this.queryString,
    required this.dataType,
  });

  Map<String, dynamic> toJson() => {
        Constants.radiusOne: radiusOne,
        Constants.radiusTwo: radiusTwo,
        Constants.centerLat: centerLat,
        Constants.centerLon: centerLon,
        Constants.queryString: queryString,
        Constants.dataType: dataType,
      };

  factory NearbyLocationPost.fromJson(
    Map<String, dynamic> json,
  ) {
    return NearbyLocationPost(
      radiusOne: json[Constants.radiusOne],
      radiusTwo: json[Constants.radiusTwo],
      centerLat: json[Constants.centerLat],
      centerLon: json[Constants.centerLon],
      queryString: json[Constants.queryString],
      dataType: json[Constants.dataType],
    );
  }
}
