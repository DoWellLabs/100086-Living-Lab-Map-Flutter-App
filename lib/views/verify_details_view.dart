import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/network/verify_details.dart';
import 'package:living_labs_maps_api/utils/colors.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 8.06.2023.
class VerifyDetailsView extends StatefulWidget {
  const VerifyDetailsView({super.key});

  @override
  State<VerifyDetailsView> createState() => _VerifyDetailsViewState();
}

class _VerifyDetailsViewState extends State<VerifyDetailsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController placeIdController = TextEditingController();

  bool loading = false;

  Future<void> onSubmitPressed() async {
    setState(() {
      loading = true;
    });
    if (_formKey.currentState!.validate()) {
      var query = cleanData(placeIdController.text.split(','));
      var response = await VerifyPlaceIds().invoke(data: query);
      setState(() {
        if (response != null) {
          newIds = response;
          existingIds =
              query.where((element) => !newIds.contains(element)).toList();
          if (newIds.isEmpty && existingIds.isEmpty) {
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
        'GhIJQWDl0CIeQUARxks3icF8U8A, ChIJj3S0t1IbLxgRYgL-7uH0NIo, ChIJrTLr-GyuEmsRBfy61i59si0,ChIJA5TnPS3nGBURRqRffftcUrk, ChIJgUbEo8cfqokR5lP9_Wh_DaM, EicxMyBNYXJrZXQgU3QsIFdpbG1pbmd0b24sIE5DIDI4NDAxLCBVU0EiGhIYChQKEgnRTo6ixx-qiRHo_bbmkCm7ZRAN, EicxMyBNYXJrZXQgU3QsIFdpbG1pbmd0b24sIE5DIDI4NDAxLCBVU0E, IhoSGAoUChIJ0U6OoscfqokR6P225pApu2UQDQ';
    await onSubmitPressed();
  }

  List<String> existingIds = [];
  List<String> newIds = [];
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
                    'Verify Place IDs',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                form(),
                existingIds.isNotEmpty || newIds.isNotEmpty
                    ? placesLayout(existingIds, newIds)
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

  Widget placesLayout(List<String> existingIds, List<String> newIds) {
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
            const Text(
              "New Id's",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                newIds.length,
                (index) => Text(
                  '• ${newIds[index]}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: primaryColor),
                ),
              ),
            ),
            const Text(
              "Existing Id's",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                existingIds.length,
                (index) => Text(
                  '• ${existingIds[index]}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: primaryColor),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
