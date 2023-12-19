import 'package:doggo_dec_18/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_18/services/service_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:doggo_dec_18/utils/service_locator.dart' as srv_loc;

import '../mock/mock_http_client_factory.dart';

void main() {
  tearDown(() {
    srv_loc.serviceLocator.unregister<http.Client>();
  });

  group('When Doggo Service', () {
    group('successfully operates', () {
      test('getBreeds returns a successful result', () {
        _testValidClident(
            MockHttpClientFactory.get200Client(_getValidJsonResponse()));
      });
    });

    group(
        'recieves a response from the services that doesnt match our expected response structure/format',
        () {
      test('getBreeds returns an unsuccessful result', () {
        _testInvalidClient(
            MockHttpClientFactory.get200Client(_getInvalidJsonResponse()));
      });
    });

    group('encounters exceptions or errors calling the external service', () {
      test('returns unsuccessful result on HttpException', () {
        _testInvalidClient(MockHttpClientFactory.getHttpExceptionClient());
      });
      test('returns unsuccessful result on TimeoutException', () {
        _testInvalidClient(MockHttpClientFactory.getTimeoutExceptionClient());
      });
      test('returns unsuccessful result on WebSocketException', () {
        _testInvalidClient(MockHttpClientFactory.getWebSocketExecptionClient());
      });
    });
  });
}

Future<void> _testValidClident(http.Client mockClient) async {
  // Inject http client into the global service locator
  srv_loc.serviceLocator.registerSingleton<http.Client>(mockClient);

  // Init the class instance containing code being tested if needed
  // - Ps no need to provide a url path, we are injecting our own http client that doesnt rely on external paths
  DoggoService doggoService = DoggoService(baseDogApiUrl: "");

  // Perform test
  ServiceResult functionResult = await doggoService.getBreeds();

  // Expect unsuccessful result
  expect(functionResult.success, true);
}

Future<void> _testInvalidClient(http.Client mockClient) async {
  // Inject http client into the global service locator
  srv_loc.serviceLocator.registerSingleton<http.Client>(mockClient);

  // Init the class instance containing code being tested if needed
  // - Ps no need to provide a url path, we are injecting our own http client that doesnt rely on external paths
  DoggoService doggoService = DoggoService(baseDogApiUrl: "");

  // Perform test
  ServiceResult functionResult = await doggoService.getBreeds();

  // Expect unsuccessful result
  expect(functionResult.success, false);
}

String _getValidJsonResponse() {
  return """[{"weight":{"imperial":"6 - 13","metric":"3 - 6"},"height":{"imperial":"9 - 11.5","metric":"23 - 29"},"id":1,"name":"Affenpinscher","bred_for":"Small rodent hunting, lapdog","breed_group":"Toy","life_span":"10 - 12 years","temperament":"Stubborn, Curious, Playful, Adventurous, Active, Fun-loving","origin":"Germany, France","reference_image_id":"BJa4kxc4X"},{"weight":{"imperial":"50 - 60","metric":"23 - 27"},"height":{"imperial":"25 - 27","metric":"64 - 69"},"id":2,"name":"Afghan Hound","country_code":"AG","bred_for":"Coursing and hunting","breed_group":"Hound","life_span":"10 - 13 years","temperament":"Aloof, Clownish, Dignified, Independent, Happy","origin":"Afghanistan, Iran, Pakistan","reference_image_id":"hMyT4CDXR"},{"weight":{"imperial":"44 - 66","metric":"20 - 30"},"height":{"imperial":"30","metric":"76"},"id":3,"name":"African Hunting Dog","bred_for":"A wild pack animal","life_span":"11 years","temperament":"Wild, Hardworking, Dutiful","reference_image_id":"rkiByec47"}]
  """;
}

String _getInvalidJsonResponse() {
  return "#!@*(!HLFAEWR) BLA BLA BLA";
}
