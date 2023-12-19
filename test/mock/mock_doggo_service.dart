import 'package:doggo_dec_18/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_18/services/doggo_service/doggo_service.dart';
import 'package:doggo_dec_18/services/service_result.dart';

class MockDoggoService extends DoggoService {
  // Ok to initialize the baseApiUrl because we are not actually making any http calls in this class
  // - Since we are mocking the class we just generate the data here instead of fetching it from external locations
  MockDoggoService() : super(baseDogApiUrl: "");

  @override
  Future<ServiceResult<List<DoggoBreed>?>> getBreeds() async {
    List<DoggoBreed> mockDoggoList = [1, 2, 3, 4, 5]
        .map((mockDoggoBreedIdx) => DoggoBreed(
            id: mockDoggoBreedIdx,
            name: "Doggo $mockDoggoBreedIdx",
            weight: "10 - 2$mockDoggoBreedIdx",
            height: "1 - $mockDoggoBreedIdx",
            lifeSpan: "50 - 6$mockDoggoBreedIdx",
            referenceImageId: "referenceImageId$mockDoggoBreedIdx"))
        .toList();

    return ServiceResult(data: mockDoggoList, success: true);
  }
}
