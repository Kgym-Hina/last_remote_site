import 'package:flutter/material.dart';

class HamToolkitPage extends StatefulWidget {
  const HamToolkitPage({super.key});

  @override
  State<HamToolkitPage> createState() => _HamToolkitPageState();
}

class _HamToolkitPageState extends State<HamToolkitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ham Toolkit'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ham Toolkit Page',
            ),
          ],
        ),
      ),
    );
  }
}
