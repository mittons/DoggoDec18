import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:doggo_dec_18/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // remember CI env stuff

  group("Run app", () {
    //
    testWidgets('eval init state, simulate user flow and eval state changes',
        (widgetTester) async {
      // Setup dependencies, injections and resources required in environment.

      // Run instance
      app.main();
      await widgetTester.pumpAndSettle();

      // Perform tests
      // ----------------------------------------------------------------------------------------
      // | Expected ui elements shown in initial state
      // ----------------------------------------------------------------------------------------
      // Scaffold
      expect(find.widgetWithText(AppBar, "Doggo Diversity Showcase"),
          findsOneWidget);
      // Doggo list request button
      expect(
          find.widgetWithText(ElevatedButton, "List dogs, please!"), findsOne);

      // -------------------------------------------------------
      // | Click "Get dog breeds" and expect a snackbar..
      // |   to be displayed
      // -------------------------------------------------------

      // Expect no "not implemented yet" snackbar to displayed before the button is pressed
      expect(
          find.widgetWithText(SnackBar,
              "This feature is not yet implemented. We are working hard to deliver on expectations!"),
          findsNothing);

      // Click the request button
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "List dogs, please!"));
      await widgetTester.pumpAndSettle();

      // Expect "not implemented yet" snackbar to displayed
      expect(
          find.widgetWithText(SnackBar,
              "This feature is not yet implemented. We are working hard to deliver on expectations!"),
          findsOneWidget);
    });
  });
}
