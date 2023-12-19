import 'package:doggo_dec_18/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_18/screens/doggo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_doggo_service.dart';

void main() {
  group('Doggo screen', () {
    //
    testWidgets('contains all expected UI elements in initial state',
        (widgetTester) async {
      // Setup dependencies, injections and resources required in environment.
      MockDoggoService mockDoggoService = MockDoggoService();

      // Run instance (unit or widget)
      await widgetTester.pumpWidget(
          MaterialApp(home: DoggoScreen(doggoService: mockDoggoService)));
      await widgetTester.pumpAndSettle();

      // Perform tests
      // ----------------------------------------------------------------------------------------
      // | Scaffold
      // ----------------------------------------------------------------------------------------
      expect(find.widgetWithText(AppBar, "Doggo Diversity Showcase"),
          findsOneWidget);

      // ----------------------------------------------------------------------------------------
      // | Doggo list request button
      // ----------------------------------------------------------------------------------------
      expect(
          find.widgetWithText(ElevatedButton, "List dogs, please!"), findsOne);
    });

    testWidgets(
        'displays list of dog(go) breeds when request button is pressed',
        (widgetTester) async {
      // Setup dependencies, injections and resources required in environment.
      MockDoggoService mockDoggoService = MockDoggoService();

      // Run instance (unit or widget)
      await widgetTester.pumpWidget(
          MaterialApp(home: DoggoScreen(doggoService: mockDoggoService)));
      await widgetTester.pumpAndSettle();

      // Get our own copy of the data that defines the expected state change
      List<DoggoBreed> dogBreeds = (await mockDoggoService.getBreeds()).data!;

      // Perform tests
      // Expect that the list of dog breeds is not displayed before the request button is ever pressed
      for (DoggoBreed doggoBreed in dogBreeds) {
        expect(find.widgetWithText(ListTile, doggoBreed.name), findsNothing);
      }

      // Press button
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "List dogs, please!"));
      await widgetTester.pumpAndSettle();

      // Expect the list of dog(go) breeds to be displayed after the request button has been pressed
      for (DoggoBreed doggoBreed in dogBreeds) {
        expect(find.widgetWithText(ListTile, doggoBreed.name), findsOneWidget);
      }
    });
  });
}
