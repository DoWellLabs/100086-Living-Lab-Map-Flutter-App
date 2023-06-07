import 'package:living_labs_maps_api/model/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class SaveDetailsModel {
  final String locationCoordinate;
  final String address;
  final List category;
  final List dayHours;
  final String placeName;
  final String phone;
  final String website;
  final String typeOfData;
  final bool isTestData;
  final List<String> eventId;
  final bool error;

  const SaveDetailsModel(
      {required this.address,
      required this.category,
      required this.placeName,
      required this.phone,
      required this.website,
      required this.typeOfData,
      required this.isTestData,
      required this.eventId,
      required this.error,
      required this.locationCoordinate,
      required this.dayHours});

  Map<String, dynamic> toJson() => {
        Constants.placeName: placeName,
        Constants.category: category,
        Constants.address: address,
        Constants.locationCoordinates: locationCoordinate,
        Constants.dayHours: dayHours,
        Constants.phone: phone,
        Constants.website: website,
        Constants.typeOfData: typeOfData,
        Constants.isTestData: isTestData,
        Constants.eventId: eventId,
        Constants.error: error,
      };
}

class PostDetails {
  final List<SaveDetailsModel>? successfulResults;
  final List<SaveDetailsModel>? failedResults;

  PostDetails(this.successfulResults, this.failedResults);

  Map<String, dynamic> toJson() => {
        Constants.resultDict: {
          Constants.successfulRes:
              successfulResults?.map((e) => e.toJson()).toList() ?? [],
          Constants.failedResults:
              failedResults?.map((e) => e.toJson()).toList() ?? [],
        }
      };
}
