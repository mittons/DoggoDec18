import 'package:doggo_dec_18/config/app_config.dart';
import 'package:doggo_dec_18/screens/doggo_screen.dart';
import 'package:doggo_dec_18/services/doggo_service/doggo_service.dart';
import 'package:flutter/material.dart';
import 'package:doggo_dec_18/utils/service_locator.dart' as srv_loc;

void main() {
  runApp(const MyAppLicences());
}

class MyAppLicences extends StatelessWidget {
  const MyAppLicences({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Licences',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const LicensePage(),
    );
  }
}
