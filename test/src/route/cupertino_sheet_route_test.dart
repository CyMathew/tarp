import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarp/route.dart';
import 'package:tarp/src/route/cupertino_sheet_route.dart';

import '../../helpers.dart';

void main() {
  group('CupertinoSheetRoute', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());

      Navigator.of(tester.contextForRootNavigator).push(
        CupertinoSheetRoute(builder: (context) => const Text('Sheet')),
      );
      await tester.pumpAndSettle();
      expect(findSheet(), findsOneWidget);
      expect(find.text('Sheet'), findsOneWidget);
    });

    testWidgets('animates previous route when using MaterialExtendedPageRoute',
        (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());
      final controller = Navigator.of(tester.contextForRootNavigator);
      controller.push(
        MaterialExtendedPageRoute(builder: (context) => const SizedBox()),
      );
      await tester.pumpAndSettle();
      controller.push(
        CupertinoSheetRoute(builder: (context) => const Text('Sheet')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoSheetBottomRouteTransition), findsOneWidget);
    });

    testWidgets('animates previous route when using CupertinoExtendedPageRoute',
        (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());
      final controller = Navigator.of(tester.contextForRootNavigator);
      controller.push(
        CupertinoExtendedPageRoute(builder: (context) => const SizedBox()),
      );
      await tester.pumpAndSettle();
      controller.push(
        CupertinoSheetRoute(builder: (context) => const Text('Sheet')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoSheetBottomRouteTransition), findsOneWidget);
    });
  });

  group('CupertinoSheetPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialPage(child: SizedBox()),
              CupertinoSheetPage(child: Text('Sheet')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(findSheet(), findsOneWidget);
      expect(find.text('Sheet'), findsOneWidget);
    });

    testWidgets('animates previous route when using MaterialExtendedPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialExtendedPage(child: SizedBox()),
              CupertinoSheetPage(child: Text('Sheet')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoSheetBottomRouteTransition), findsOneWidget);
    });

    testWidgets('animates previous route when using CupertinoExtendedPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              CupertinoExtendedPage(child: SizedBox()),
              CupertinoSheetPage(child: Text('Sheet')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.byType(CupertinoSheetBottomRouteTransition), findsOneWidget);
    });
  });
}
