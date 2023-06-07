import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/model/save_details_model.dart';
import 'package:living_labs_maps_api/network/save_details.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 7.06.2023.
class SavingDetailsView extends StatefulWidget {
  const SavingDetailsView({super.key});

  @override
  State<SavingDetailsView> createState() => _SavingDetailsViewState();
}

class _SavingDetailsViewState extends State<SavingDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController typeOfDataController = TextEditingController();
  final TextEditingController eventIdController = TextEditingController();
  final TextEditingController locationCoordinateController =
      TextEditingController();
  final TextEditingController dayHoursController = TextEditingController();

  bool loading = false;
  bool isTestData = false;
  bool error = false;
  bool successfulRes = true;

  Future<void> onSubmitPressed() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      SaveDetailsModel place = SaveDetailsModel(
        address: addressController.text,
        category: categoryController.text.split(','),
        placeName: placeNameController.text,
        phone: phoneController.text,
        website: websiteController.text,
        typeOfData: typeOfDataController.text,
        isTestData: isTestData,
        eventId: eventIdController.text.split(','),
        error: error,
        locationCoordinate: locationCoordinateController.text,
        dayHours: dayHoursController.text.split(','),
      );
      PostDetails data = successfulRes
          ? PostDetails([place], null)
          : PostDetails(null, [place]);

      var response = await PostPlaceDetails().invoke(data: data);
      setState(() {
        String message =
            response?.replaceAll('"', '') ?? 'Failed, please try again';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(child: Text(message)),
        ));
        loading = false;
      });
    }
  }

  Future<void> onTestPressed() async {
    placeNameController.text = 'Whitefield Restaurant';
    categoryController.text =
        'restaurant, food, point_of_interest, establishment';
    addressController.text =
        'kingara Road, opp kingara close behind Junction Mall, Nairobi, Kenya';
    locationCoordinateController.text = '-1.2960063 , 36.7616708';
    dayHoursController.text = 'None';
    phoneController.text = '+254 742 894700';
    websiteController.text = 'https://whitefieldrestaurant.reserveport.com/';
    typeOfDataController.text = 'scraped';
    eventIdController.text = 'FB1010000000000000000000003004';
    isTestData = true;
    error = true;
    await onSubmitPressed();
  }

  @override
  void dispose() {
    placeNameController.dispose();
    categoryController.dispose();
    addressController.dispose();
    locationCoordinateController.dispose();
    dayHoursController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    typeOfDataController.dispose();
    eventIdController.dispose();
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
                    'Save Place Details',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                form(),
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
            controller: placeNameController,
            decoration: const InputDecoration(
                hintText: 'Enter Place Name', border: OutlineInputBorder()),
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
            controller: categoryController,
            decoration: const InputDecoration(
                hintText: 'Enter Categories(separated by ,`comma`)',
                border: OutlineInputBorder()),
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
            controller: addressController,
            decoration: const InputDecoration(
                hintText: 'Enter address', border: OutlineInputBorder()),
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
            controller: locationCoordinateController,
            decoration: const InputDecoration(
                hintText: 'Enter location coordinate(separate by , `comma`)',
                border: OutlineInputBorder()),
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
            controller: dayHoursController,
            decoration: const InputDecoration(
                hintText: 'Enter day hours (separated by , `comma`)',
                border: OutlineInputBorder()),
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
            controller: phoneController,
            decoration: const InputDecoration(
                hintText: 'Enter phone number', border: OutlineInputBorder()),
            keyboardType: TextInputType.phone,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: websiteController,
            decoration: const InputDecoration(
                hintText: 'Enter website url', border: OutlineInputBorder()),
            keyboardType: TextInputType.url,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: typeOfDataController,
            decoration: const InputDecoration(
                hintText: 'Enter type of data', border: OutlineInputBorder()),
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
            controller: eventIdController,
            decoration: const InputDecoration(
                hintText: 'Enter event id (separated by , `comma)',
                border: OutlineInputBorder()),
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Enter valid value';
              return null;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Checkbox(
                    value: isTestData,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isTestData = newValue ?? false;
                      });
                    }),
                const Text('Test Data'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: error,
                    onChanged: (bool? newValue) {
                      setState(() {
                        error = newValue ?? false;
                      });
                    }),
                const Text('Error'),
              ],
            ),
          ],
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
}
