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
