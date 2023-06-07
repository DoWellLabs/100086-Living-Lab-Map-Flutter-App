import 'dart:convert';
import 'dart:io';
import 'package:living_labs_maps_api/model/constants.dart';
import 'package:living_labs_maps_api/model/save_details_model.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class GetPlaceDetails {
  Future<List<SaveDetailsModel>?> invoke({required List<String> data}) async {
    //URL and Data
    String url =
        'https://100086.pythonanywhere.com/accounts/get-details-list-stage1/';

    Map jsonMap = {"place_id_list": data};

    //Init Request
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    //Set Headers and encoding
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));

    //Get and shut down the http client
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    //Decode the response
    if (response.statusCode == 200) {
      var json = jsonDecode(reply);
      List places = json[Constants.successfulRes] as List;
      return places.map((e) => SaveDetailsModel.fromJson(e)).toList();
    }
    return null;
  }
}
