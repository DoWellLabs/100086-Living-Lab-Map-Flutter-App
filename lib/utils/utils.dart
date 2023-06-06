import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/views/get_nearby_locations.dart';
import 'package:living_labs_maps_api/views/place_details.dart';
import 'package:living_labs_maps_api/views/saving_details.dart';
import 'package:living_labs_maps_api/views/verify_details_view.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.

List<Widget> homeScreenItems = [
  const NearbyLocationsView(),
  const PlaceDetailsView(),
  const SavingDetailsView(),
  const VerifyDetailsView(),
];
