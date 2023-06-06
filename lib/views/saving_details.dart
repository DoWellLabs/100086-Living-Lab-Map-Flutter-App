import 'package:flutter/material.dart';

class SavingDetailsView extends StatefulWidget {
  const SavingDetailsView({super.key});

  @override
  State<SavingDetailsView> createState() => _SavingDetailsViewState();
}

class _SavingDetailsViewState extends State<SavingDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Saving Details',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ));
  }
}
