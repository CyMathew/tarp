import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarp/route.dart';

import '../../helpers.dart';

void main() {
  group('SheetRoute', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());

      Navigator.of(tester.contextForRootNavigator).push(
        SheetRoute(builder: (context) => const Text('Sheet')),
      );
      await tester.pumpAndSettle();
      expect(findSheet(), findsOneWidget);
      expect(find.text('Sheet'), findsOneWidget);
    });
  });

  group('SheetPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialPage(child: SizedBox()),
              SheetPage(child: Text('Sheet')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(findSheet(), findsOneWidget);
      expect(find.text('Sheet'), findsOneWidget);
    });
  });
}
