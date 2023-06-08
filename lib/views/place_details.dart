import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/model/save_details_model.dart';
import 'package:living_labs_maps_api/network/get_place_details.dart';
import 'package:living_labs_maps_api/utils/colors.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class PlaceDetailsView extends StatefulWidget {
  const PlaceDetailsView({super.key});

  @override
  State<PlaceDetailsView> createState() => _PlaceDetailsViewState();
}

class _PlaceDetailsViewState extends State<PlaceDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController placeIdController = TextEditingController();

  bool loading = false;

  Future<void> onSubmitPressed() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      var response = await GetPlaceDetails()
          .invoke(data: cleanData(placeIdController.text.split(',')));
      setState(() {
        if (response != null) {
          places = response;
          if (places.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Center(child: Text('An error occurred, try again.')),
            ));
          }
        }
        loading = false;
      });
    }
  }

  List<String> cleanData(List<String> dirtyData) {
    List<String> cleanData = [];
    for (var element in dirtyData) {
      cleanData.add(element.trim());
    }
    return cleanData;
  }

  Future<void> onTestPressed() async {
    placeIdController.text =
        'ChIJj3S0t1IbLxgRYgL-7uH0NIo, ChIJH-YvVNtjhxcRBKtosJMZigI, ChIJsUIT2etjhxcRpvvxvXinMMM, ChIJB_0xDeUZLxgRZDlv3RP72CY, ChIJh75PpvIeLxgRaPu-_UdT9i4,ChIJ7VT_aMwWLxgRIUerCmXISKM, ChIJVVVV5XomLxgRgEK1BB2YarcVMHP+VQ8';

    await onSubmitPressed();
  }

  List<SaveDetailsModel> places = [];
  @override
  void dispose() {
    placeIdController.dispose();
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
                    'Get Place Details',
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
            controller: placeIdController,
            decoration: const InputDecoration(
                hintText: 'Enter Place Id (separated by , `comma`)',
                border: OutlineInputBorder()),
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

  Widget placesLayout(SaveDetailsModel data) {
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
                text: 'Address: ',
                children: [
                  TextSpan(
                      text: data.address,
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
                text: 'Day Hours: ',
                children: [
                  TextSpan(
                      text: data.dayHours.toString(),
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
