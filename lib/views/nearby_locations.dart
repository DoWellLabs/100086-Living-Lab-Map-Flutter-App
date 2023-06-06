import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/model/post_nearby_locations.dart';
import 'package:living_labs_maps_api/network/get_nearby_lacations.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController radiusOneController = TextEditingController();
  final TextEditingController radiusTwoController = TextEditingController();
  final TextEditingController centerLatController = TextEditingController();
  final TextEditingController centerLonController = TextEditingController();
  final TextEditingController queryStringController = TextEditingController();
  final TextEditingController dataTypeController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: radiusOneController,
                decoration: const InputDecoration(
                  hintText: 'Radius 1',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              TextFormField(
                controller: radiusTwoController,
                decoration: const InputDecoration(
                  hintText: 'Radius 2',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              TextFormField(
                controller: centerLatController,
                decoration: const InputDecoration(
                  hintText: 'Center Latitude',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              TextFormField(
                controller: centerLonController,
                decoration: const InputDecoration(
                  hintText: 'Center Longitude',
                ),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              TextFormField(
                controller: queryStringController,
                decoration: const InputDecoration(
                  hintText: 'Query String',
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              TextFormField(
                controller: dataTypeController,
                decoration: const InputDecoration(
                  hintText: 'Data Type',
                ),
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter valid value';
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  print(_formKey.currentState!.validate());
                  if (_formKey.currentState!.validate()) {
                    NearbyLocationPost data = NearbyLocationPost(
                      radiusOne: int.parse(radiusOneController.text),
                      radiusTwo: int.parse(radiusTwoController.text),
                      centerLat: double.parse(centerLatController.text),
                      centerLon: double.parse(centerLonController.text),
                      queryString: queryStringController.text,
                      dataType: dataTypeController.text,
                    );
                    var response =
                        await GetNearbyLocations().invoke(data: data);
                    print('RE - $response');
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
