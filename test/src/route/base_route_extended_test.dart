import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarp/route.dart';

import '../../helpers.dart';

void main() {
  group('MaterialExtendedPageRoute', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());

      Navigator.of(tester.contextForRootNavigator).push(
        MaterialExtendedPageRoute(builder: (context) => const Text('child')),
      );
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    test('is a PreviousSheetRouteMixin', () {
      expect(
        MaterialExtendedPageRoute(builder: (context) => const Text('child')),
        isA<PreviousSheetRouteMixin>(),
      );
    });

    test('is a DelegatedTransitionsRoute', () {
      expect(
        MaterialExtendedPageRoute(builder: (context) => const Text('child')),
        isA<DelegatedTransitionsRoute>(),
      );
    });

    test('is a MaterialPageRoute', () {
      expect(
        MaterialExtendedPageRoute(builder: (context) => const Text('child')),
        isA<MaterialPageRoute>(),
      );
    });
  });

  group('MaterialExtendedPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialExtendedPage(child: Text('child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('navigating to different routes keeping the same page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialExtendedPage(child: Text('first child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.text('first child'), findsOneWidget);

      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              MaterialExtendedPage(child: Text('second child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));

      await tester.pumpAndSettle();
      expect(find.text('second child'), findsOneWidget);
    });

    testWidgets('route is a MaterialExtendedPageRoute',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [MaterialPage(child: SizedBox())],
            onPopPage: (route, result) => false,
          );
        },
      ));
      expect(
        const MaterialExtendedPage(child: Text('child'))
            .createRoute(tester.contextForRootNavigator),
        isA<MaterialExtendedPageRoute>(),
      );
    });

    testWidgets('params are passed to route', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [MaterialPage(child: SizedBox())],
            onPopPage: (route, result) => false,
          );
        },
      ));
      const page = MaterialExtendedPage(
        child: Text('child'),
        fullscreenDialog: true,
        maintainState: false,
      );
      expect(
        page.createRoute(tester.contextForRootNavigator),
        isA<MaterialExtendedPageRoute>()
            .having(
              (p) => p.fullscreenDialog,
              'fullscreenDialog',
              isTrue,
            )
            .having(
              (p) => p.settings,
              'settings',
              page,
            )
            .having(
              (p) => p.maintainState,
              'maintainState',
              isFalse,
            ),
      );
    });
  });
  group('CupertinoExtendedPageRoute', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpApp(const SizedBox());

      Navigator.of(tester.contextForRootNavigator).push(
        CupertinoExtendedPageRoute(builder: (context) => const Text('child')),
      );
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    test('is a PreviousSheetRouteMixin', () {
      expect(
        CupertinoExtendedPageRoute(builder: (context) => const Text('child')),
        isA<PreviousSheetRouteMixin>(),
      );
    });

    test('is a DelegatedTransitionsRoute', () {
      expect(
        CupertinoExtendedPageRoute(builder: (context) => const Text('child')),
        isA<DelegatedTransitionsRoute>(),
      );
    });

    test('is a CupertinoPageRoute', () {
      expect(
        CupertinoExtendedPageRoute(builder: (context) => const Text('child')),
        isA<CupertinoPageRoute>(),
      );
    });
  });

  group('CupertinoExtendedPage', () {
    testWidgets('renders', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              CupertinoExtendedPage(child: Text('child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.text('child'), findsOneWidget);
    });

    testWidgets('navigating to different routes keeping the same page',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              CupertinoExtendedPage(child: Text('first child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));
      await tester.pumpAndSettle();
      expect(find.text('first child'), findsOneWidget);

      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [
              CupertinoExtendedPage(child: Text('second child')),
            ],
            onPopPage: (route, result) => false,
          );
        },
      ));

      await tester.pumpAndSettle();
      expect(find.text('second child'), findsOneWidget);
    });

    testWidgets('route is a CupertinoExtendedPageRoute',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [MaterialPage(child: SizedBox())],
            onPopPage: (route, result) => false,
          );
        },
      ));
      expect(
        const CupertinoExtendedPage(child: Text('child'))
            .createRoute(tester.contextForRootNavigator),
        isA<CupertinoExtendedPageRoute>(),
      );
    });

    testWidgets('params are passed to route', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) {
          return Navigator(
            pages: const [MaterialPage(child: SizedBox())],
            onPopPage: (route, result) => false,
          );
        },
      ));
      const page = CupertinoExtendedPage(
        child: Text('child'),
        title: 'Title',
        fullscreenDialog: true,
        maintainState: false,
      );
      expect(
        page.createRoute(tester.contextForRootNavigator),
        isA<CupertinoExtendedPageRoute>()
            .having(
              (p) => p.fullscreenDialog,
              'fullscreenDialog',
              isTrue,
            )
            .having(
              (p) => p.settings,
              'settings',
              page,
            )
            .having(
              (p) => p.maintainState,
              'maintainState',
              isFalse,
            )
            .having(
              (p) => p.title,
              'title',
              equals('Title'),
            ),
      );
    });
  });
}
