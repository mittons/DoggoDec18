import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:doggo_dec_18/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const ciRun = bool.fromEnvironment('CI', defaultValue: false);

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

      // -------------------------------------------------------------
      // | Click "Get dog breeds" and expect a list of doggo breeds..
      // |   to be displayed
      // -------------------------------------------------------------

      // Expect no list tiles to displayed before the button is ever pressed
      expect(find.byType(ListTile), findsNothing);

      // Click the request button
      await widgetTester
          .tap(find.widgetWithText(ElevatedButton, "List dogs, please!"));
      await widgetTester.pumpAndSettle();

      // If the CI flag isn't set we arent running against a service/service response path we know is in an environment we control
      // - So we give the service a few seconds to respond.
      if (!ciRun) {
        await Future.delayed(const Duration(seconds: 5));
      }

      // Expect that the list has been initialized and list tiles are being displayed after the button is pressed
      expect(find.byType(ListTile), findsAtLeastNWidgets(1));

      // If we are doing a run with the CI flag set we can assume that we are running against a mock api service running locally
      // - With predefined dataset. We assume we are running against the docker image mockdogapidec18.
      //   - In that case we test against the expected data
      for (String dogBreed in [
        "Affenpinscher",
        "Afghan Hound",
        "African Hunting Dog"
      ]) {
        expect(find.widgetWithText(ListTile, dogBreed), findsOneWidget);
      }
    });
  });
}
