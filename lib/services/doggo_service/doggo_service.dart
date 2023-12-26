import 'dart:convert';

import 'package:doggo_dec_18/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_18/services/service_result.dart';
import 'package:http/http.dart' as http;
import 'package:doggo_dec_18/utils/service_locator.dart' as srv_loc;

class DoggoService {
  final String baseDogApiUrl;

  DoggoService({required this.baseDogApiUrl});

  http.Client _getHttpClient() {
    return srv_loc.serviceLocator<http.Client>();
  }

  String _generateRequestUrl(String endpointRoute) {
    return "$baseDogApiUrl$endpointRoute";
  }

  Future<ServiceResult<List<DoggoBreed>?>> getBreeds() async {
    // Define response
    late final http.Response response;

    // Try fetching from api
    try {
      response =
          await _getHttpClient().get(Uri.parse(_generateRequestUrl("/breeds")));
    } catch (e) {
      print("Error fetching data from the external service: $e");
      return ServiceResult(data: null, success: false);
    }

    // Check if the response code was correct (200), else return unsuccessful response
    if (response.statusCode != 200) {
      print("Invalid http status code from service: ${response.statusCode}");
      return ServiceResult(data: null, success: false);
    }

    // If everything worked until now, try parsing the the json response and returning a successful result
    try {
      final parsedJson = jsonDecode(response.body);

      List<DoggoBreed> dogBreeds = (parsedJson as List)
          .map((breedJson) => DoggoBreed.fromJson(breedJson))
          .toList();

      return ServiceResult(data: dogBreeds, success: true);
    } catch (e) {
      print(
          "Error parsing data from json response body returned by service: $e");
      return ServiceResult(data: null, success: false);
    }
  }
}
