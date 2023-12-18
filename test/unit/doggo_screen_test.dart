import 'package:doggo_dec_18/screens/doggo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Doggo screen', () {
    //
    testWidgets('contains all expected UI elements in initial state',
        (widgetTester) async {
      // Setup dependencies, injections and resources required in environment.

      // Run instance (unit or widget)
      await widgetTester.pumpWidget(MaterialApp(home: DoggoScreen()));
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
        'displays "Feature not implemented" snackbar when request button is pressed',
        (widgetTester) async {
      // Setup dependencies, injections and resources required in environment.

      // Run instance (unit or widget)
      await widgetTester.pumpWidget(MaterialApp(home: DoggoScreen()));
      await widgetTester.pumpAndSettle();

      // Perform tests

      // Press button

      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "List dogs, please!"));
      await widgetTester.pumpAndSettle();

      // Expect gracious user error message
      expect(
          find.widgetWithText(SnackBar,
              "This feature is not yet implemented. We are working hard to deliver on expectations!"),
          findsOneWidget);
    });
  });
}
