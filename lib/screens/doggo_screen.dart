import 'package:doggo_dec_18/helpers/ui_helper.dart';
import 'package:flutter/material.dart';

class DoggoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DoggoScreenState();
}

class _DoggoScreenState extends State<DoggoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doggo Diversity Showcase")),
      backgroundColor: Colors.deepPurpleAccent.shade100,
      body: Column(children: [_buildButtonContainer()]),
    );
  }

  Widget _buildButtonContainer() {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 9, bottom: 10),
      child: ElevatedButton(
        onPressed: _handleRequestButtonPressed,
        child: const Text("List dogs, please!"),
      ),
    );
  }

  void _handleRequestButtonPressed() {
    UiHelper.displaySnackbar(context,
        "This feature is not yet implemented. We are working hard to deliver on expectations!");
    // throw UnimplementedError();
  }
}
