import 'package:flutter/material.dart';

class VerifyDetailsView extends StatefulWidget {
  const VerifyDetailsView({super.key});

  @override
  State<VerifyDetailsView> createState() => _VerifyDetailsViewState();
}

class _VerifyDetailsViewState extends State<VerifyDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Verify Places Id',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    ));
  }
}
