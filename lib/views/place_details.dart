import 'package:flutter/material.dart';

class PlaceDetailsView extends StatefulWidget {
  const PlaceDetailsView({super.key});

  @override
  State<PlaceDetailsView> createState() => _PlaceDetailsViewState();
}

class _PlaceDetailsViewState extends State<PlaceDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Places Details',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ));
  }
}
