# selection

A new Flutter package project.

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

The color and shape are adjusted to suit my convenience.
I'm sorry for explaining the behavior, please touch example.

Thank you.