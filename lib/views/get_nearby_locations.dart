import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/model/get_nearby_locations.dart';
import 'package:living_labs_maps_api/model/post_nearby_locations.dart';
import 'package:living_labs_maps_api/network/get_nearby_lacations.dart';
import 'package:living_labs_maps_api/utils/colors.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.

class NearbyLocationsView extends StatefulWidget {
  const NearbyLocationsView({super.key});

  @override
  State<NearbyLocationsView> createState() => _NearbyLocationsViewState();
}

class _NearbyLocationsViewState extends State<NearbyLocationsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController radiusOneController = TextEditingController();
  final TextEditingController radiusTwoController = TextEditingController();
  final TextEditingController centerLatController = TextEditingController();
  final TextEditingController centerLonController = TextEditingController();
  final TextEditingController queryStringController = TextEditingController();
  final TextEditingController dataTypeController = TextEditingController();

  bool loading = false;

  Future<void> onSubmitPressed() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      NearbyLocationPost data = NearbyLocationPost(
        radiusOne: int.parse(radiusOneController.text),
        radiusTwo: int.parse(radiusTwoController.text),
        centerLat: double.parse(centerLatController.text),
        centerLon: double.parse(centerLonController.text),
        queryString: queryStringController.text,
        dataType: dataTypeController.text,
      );
      var response = await GetNearbyLocations().invoke(data: data);
      setState(() {
        if (response != null) {
          places = response;
          if (places.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(child: Text('No nearby locations found.')),
            ));
          }
        }
        loading = false;
      });
    }
  }

  Future<void> onTestPressed() async {
    radiusOneController.text = '0';
    radiusTwoController.text = '750';
    centerLatController.text = '51.50853';
    centerLonController.text = '-0.12574';
    queryStringController.text = 'school';
    dataTypeController.text = 'scraped';
    await onSubmitPressed();
  }

  List<NearbyLocationGet> places = [];
  @override
  void dispose() {
    radiusOneController.dispose();
    radiusTwoController.dispose();
    centerLatController.dispose();
    centerLonController.dispose();
    queryStringController.dispose();
    dataTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Get Nearby Locations',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                form(),
                places.isNotEmpty
                    ? Column(
                        children: List.generate(places.length,
                            (index) => placesLayout(places[index])),
                      )
                    : const SizedBox()
              ],
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget form() {
    return SafeArea(
        child: Form(
      key: _formKey,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: radiusOneController,
            decoration: const InputDecoration(
                hintText: 'Radius 1', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: radiusTwoController,
            decoration: const InputDecoration(
                hintText: 'Radius 2', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: centerLatController,
            decoration: const InputDecoration(
                hintText: 'Center Latitude', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: centerLonController,
            decoration: const InputDecoration(
                hintText: 'Center Longitude', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: queryStringController,
            decoration: const InputDecoration(
                hintText: 'Query String', border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: dataTypeController,
            decoration: const InputDecoration(
                hintText: 'Data Type', border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: TextButton(
                onPressed: () async {
                  await onSubmitPressed();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: TextButton(
                onPressed: () async {
                  await onTestPressed();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: const Text(
                    'Test',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    ));
  }

  Widget placesLayout(NearbyLocationGet data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Text('Id: ${data.id}',
            //     style:
            //         const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            RichText(
              text: TextSpan(
                text: 'Name: ',
                children: [
                  TextSpan(
                      text: data.placeName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor))
                ],
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Coordinates: ',
                children: [
                  TextSpan(
                      text: data.locationCoordinate,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor))
                ],
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
              ),
            ),

            RichText(
              text: TextSpan(
                text: 'Distance: ',
                children: [
                  TextSpan(
                      text: '${data.haversineDistance}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor))
                ],
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Category: ',
                children: [
                  TextSpan(
                      text: data.category.join(', '),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: primaryColor))
                ],
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: primaryColor),
              ),
            ),

            // Text('Place Id: ${data.placeId}',
            //     style:
            //         const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ]),
        ),
      ),
    );
  }
}
