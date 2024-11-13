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
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 500,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ham Toolkit',
                      style: Theme.of(context).textTheme.displayMedium
                  ),
                  Text(
                      '业余无线电爱好者必备的工具集',
                      style: Theme.of(context).textTheme.titleMedium
                  ),
                ],
              ),
            ),
          ),
          
          const Card.filled(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("sadr"),
            ),
          )

        ],
      ),
    );
  }
}
