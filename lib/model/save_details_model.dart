import 'package:living_labs_maps_api/model/constants.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class SaveDetailsModel {
  final String locationCoordinate;
  final String address;
  final List category;
  final List dayHours;
  final String placeId;
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
      required this.placeId,
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
        Constants.placeId: placeId,
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

// {
// "result_dict":{
//     "succesful_results": [
//         {
//             "place_id": "ChIJj3S0t1IbLxgRYgL-7uH0NIo",
//             "place_name": "Whitefield Restaurant",
//             "category": [
//                 "restaurant",
//                 "food",
//                 "point_of_interest",
//                 "establishment"
//             ],
//             "address": "kingara Road, opp kingara close behind Junction Mall, Nairobi, Kenya",
//             "location_coord": "-1.2960063 , 36.7616708",
//             "day_hours": [
//                 "Monday: 11:00 AM – 9:00 PM",
//                 "Tuesday: 11:00 AM – 9:00 PM",
//                 "Wednesday: 11:00 AM – 9:00 PM",
//                 "Thursday: 11:00 AM – 9:00 PM",
//                 "Friday: 11:00 AM – 9:00 PM",
//                 "Saturday: 11:00 AM – 9:00 PM",
//                 "Sunday: 11:00 AM – 9:00 PM"
//             ],
//             "phone": "+254 742 894700",
//             "website": "https://whitefieldrestaurant.reserveport.com/",
//             "type_of_data": "scraped",
//             "is_test_data": false,
//             "eventId": [
//                 "FB1010000000000000000000003004"
//             ],
//             "error": false
//         }
//     ],
//     "failed_results": [
//         {
//             "place_id": "EicxMyBNYXJrZXQgU3QsIFdpbG1pbmd0b24sIE5DIDI4NDAxLCBVU0EiGhIYChQKEgnRTo6ixx-qiRHo_bbmkCm7ZRAN",
//             "place_name": "None",
//             "category": "None",
//             "address": "None",
//             "location_coord": "None , None",
//             "day_hours": "None",
//             "phone": "None",
//             "website": "None",
//             "type_of_data": "scraped",
//             "is_test_data": true,
//             "eventId": [
//                 "FB1010000000000000000000003004"
//             ],
//             "error": true
//         }
//     ]
// }
// }