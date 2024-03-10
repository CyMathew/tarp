# Tarp

Forked from Jaime Blasco's Sheet Flutter package (since it seems to have been abandoned)  
https://github.com/jamesblasco/modal_bottom_sheet/tree/main/sheet

<img src="assets/sheet.gif?raw=true">


A fully customizable draggable bottom sheet for Flutter
A canvas modal package that covers up part of the main screen

It allows to add a [Sheet] widget to any page or push a new [SheetRoute] to your navigator.

## Getting Started

Add tarp to your pubspec 

```yaml
    tarp:
        git:
            url: https://github.com/CyMathew/tarp
```

Learn more about:
  - Using `Sheet` to create bottom sheets inside your page
  - Using `SheetRoute` or `SheetPage` to push a new modal bottom sheet route

## Sheet

```dart
Sheet(
 initialExtent: 200,
 child: Container(color: Colors.blue[100]),
)
```

You can add it above any other widget. Usually you might want to use a Stack for that

```dart
Stack(
 children: [
  body,   
  Sheet(
    initialExtent: 200,
    child: Container(color: Colors.blue[100]),
  ),
 ],
)
```


The widget has several parameters that allow fully customization of the sheet

### Add an initial position

Use `initialExtent` to set a initial offset from the bottom

```dart
Sheet(
 initialExtent: 200,
 child: Container(color: Colors.blue[100]),
)
```

### Clamp the sheet between a min and maximum values

You can set a `minExtent` and `maxExtent` to limit the position of the Sheet between those values

```dart
Sheet(
 initialExtent: 200,
 minExtent: 100,
 maxExtent: 400,
 child: Container(color: Colors.blue[100]),
)
```


### Allow to open the sheet when is fully hidden

When the sheet is hidden you might wanna allow the user to drag up the bottom sheet even if this one is no visible. You can define an area where the interaction can be detected

```dart
Sheet(
 initialExtent: 0,
 minInteractionExtent: 20,
 child: Container(color: Colors.blue[100]),
)
```


### Fit modes

By default the sheet height will be the minimum between the max available height and the one recommended by the child.

It is possible to force the sheet child to be the maximum size available by setting  `SheetFit.expand`

```dart
Sheet(
 initialExtent: 200,
 fit: SheetFit.expand,
 child: Container(color: Colors.blue[100]),
)
```

### Resizable

By default the sheet has a fixed sized and it is vertically translated according to the user drag.
It is possible to make the sheet change the height of the child by setting `resize: true`
This will force the child to fit the available visual space.

```dart
Sheet(
 initialExtent: 200,
 resizable:true
 child: Container(color: Colors.blue[100]),
)
```

### Resizable with min size extent

It is possible to set a min height for a resizable sheet. When the height reaches that min value, the sheet 
will start vertically translating instead of shrinking

```dart
Sheet(
 initialExtent: 200,
 resizable: true
 child: Container(color: Colors.blue[100]),
)
```


### Control the position of the sheet

It is possible to pass a `SheetController` to control programmatically the position of the sheet.

```dart
SheetController controller = SheetController();

Sheet(
 controller: controller,
 initialExtent: 200,
child: Container(color: Colors.blue[100]),
)

controller.jumpTo(400); 
controller.relativeJumpTo(1); // Value between 0 and 1


controller.animateTo(400, ...); 
controller.relativeAnimateTo(1, ...); // Value between 0 and 1
```

The sheet controller also contains an animation value that can be used to animate other parts of the ui in sync

```dart
AnimatedBuilder(
 animation: controller.animation,
 builder: (context, child) {
     return ...;
 }
);
```


## Sheet Route

You can push a new modal bottom sheet route above your current page using `SheetRoute`


```dart
SheetRoute<void>(
  builder: (BuildContext) => Container(),
)
```

Or you can also use `SheetPage` with the Navigator 2.0

```dart
Navigator(
  pages: <Page<dynamic>>[
    MaterialPage<bool>(
      key: const ValueKey<String>('BooksListPage'),
      child: BooksListScreen(
        books: books,
        onTapped: _handleBookTapped,
      ),
    ),
    if (_selectedBook != null)
      SheetPage<void>(
          key: ValueKey<Book?>(_selectedBook),
          child: BookDetailsScreen(book_selectedBook!),
          barrierColor: Colors.black26,
      )
  ],
)
```

### Go_Router Example
An example using [GoRouter](https://pub.dev/packages/go_router) is available [here](https://github.com/cymathew/tarp/blob/main/example/lib/examples/route/navigation/go_router.dart)

```dart
 late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return MaterialExtendedPage<void>(
              key: state.pageKey,
              child: BooksListScreen(
                books: books,
                onBrigthnessChanged: (Brightness brightness) {
                  setState(() {
                    this.brightness = brightness;
                  });
                },
              ),
            );
          },
          routes: <GoRoute>[
            GoRoute(
              name: 'book',
              path: 'book/:bid',
              pageBuilder: (BuildContext context, GoRouterState state) {
                final String id = state.pathParameters['bid']!;
                final Book? book =
                    books.firstWhereOrNull((Book b) => b.id == id);
                return CupertinoSheetPage<void>(
                  key: state.pageKey,
                  child: BookDetailsScreen(
                    book: book!,
                  ),
                );
              },
              redirect: (context, state) {
                final String id = state.pathParameters['bid']!;
                final Book? book =
                    books.firstWhereOrNull((Book b) => b.id == id);
                if (book == null) {
                  return '/404';
                }
                // no need to redirect at all
                return null;
              },
            ),
          ]),
    ],
  );
  ```


### Set the initial position

Use `initialExtent` to set the initial position the bottom sheet will be dragged to:

```dart
SheetRoute(
 initialExtent: 200,
 builder: (BuildContext) => Container(color: Colors.blue[100]),
)
```

### Cause previous page to push back

In order for the previous route to be affected by a fullscreen modal, you'll need to use `MaterialExtendedPageRoute` or `MaterialExtendedPage` to transition to the page in question.

Using Navigator:

```dart
Navigator.of(context).push(MaterialExtendedPageRoute((context) => (_YOUR_PAGE_HERE)));
```

Once you are on a `MaterialExtendedPage` or navigated to it via a `MaterialExtendedPageRoute` then you can use `CupertinoSheetRoute` or `CupertinoSheetPage` to have iOS style modals

```dart
Navigator.of(context).push(
    CupertinoSheetRoute<void>(
        initialDetent: Detents.medium,
        detents: <double>[
            Detents.none,
            Detents.medium,
            Detents.large
        ],
        builder: (BuildContext context) => const ModalFit(),
    ),
);
```