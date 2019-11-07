# selection

Radio button with focus. Developed for flutter for web but can also be used on Android. iOS is unverified, but probably works..

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

Here is a new type radio. It is able to select exclusively.
I'll describe how to use.

## How it works

Focus widget is a top-level child.
The radio button for the web doesn't accept the tab key, so I made it.
Please make the content with SelectionManifest<T> class.
Also, define the selection value in enum and supply its name in the <T> part.

# Usage

To use this plugin, add `selection` as a [dependency in your pubspec.yaml file.](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

# Example

```dart
import 'package:flutter/material.dart';
import 'package:selection/selection.dart';

/// For Selection parts begin.
enum Sex {
  notKnown,
  male,
  female,
  not_applicable,
}
List<SelectionManifest<Sex>> _sexManifest = [
  SelectionManifest<Sex>(
      label: 'not known', value: Sex.notKnown, width: 120, height: 40),
  SelectionManifest<Sex>(
      label: 'male', value: Sex.male, width: 90, height: 40),
  SelectionManifest<Sex>(
      label: 'female', value: Sex.female, width: 100, height: 40),
  SelectionManifest<Sex>(
      label: 'not applicable', value: Sex.not_applicable, width: 150, height: 40),
];

enum DominantHand {
  notKnown,
  left,
  right,
}
List<SelectionManifest<DominantHand>> _dominantHandManifest = [
  SelectionManifest<DominantHand>(
      label: 'not known', value: DominantHand.notKnown, width: 120, height: 40),
  SelectionManifest<DominantHand>(
      label: 'left', value: DominantHand.left, width: 80, height: 40),
  SelectionManifest<DominantHand>(
      label: 'right', value: DominantHand.right, width: 90, height: 40),
];
/// For Selection parts end.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// For Selection parts begin.
  final focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  final _sex = <Sex>[null];
  final _dominant = <DominantHand>[null];
  /// For Selection parts end.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Selection(
                      focusNodes: focusNodes,
                      focusNodeIndex: 0,
                      manifests: _sexManifest,
                      selectedValue: _sex),
                  SizedBox(height: 8),
                  Selection(
                      focusNodes: focusNodes,
                      focusNodeIndex: 1,
                      manifests: _dominantHandManifest,
                      selectedValue: _dominant)
                ])));
  }
}
```

>Selection(
>      {this.key,
>        this.focusNodes,
>        this.focusNodeIndex,
>        this.manifests,
>        this.selectedValue})
>      : super(key: key);

'key' is not used as this class.
'focusNodes' is an array of FocusNodes. It will take the same number of widgets to tabbing.
'focusNodeIndex' is a so-called tab index.
'manifests' describes the nature of the content.
'selectedValue' is designed to use the 0th array so that the value can be changed from the outside.
Type T must be created with enum.

You may need a script to disable tab key in index.html for web.

The color and shape are adjusted to suit my convenience.
I'm sorry for explaining the behavior, please touch example.

Thank you.