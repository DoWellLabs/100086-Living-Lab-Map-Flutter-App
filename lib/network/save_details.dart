import 'dart:convert';
import 'dart:io';
import 'package:living_labs_maps_api/model/save_details_model.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class PostPlaceDetails {
  Future<String?> invoke({required PostDetails data}) async {
    //URL and Data
    String url =
        'https://100086.pythonanywhere.com/accounts/save-places-detail/';
    Map jsonMap = data.toJson();

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
      return reply;
    }
    return null;
  }
}
