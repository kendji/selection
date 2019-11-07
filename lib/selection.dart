library selection;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectionManifest<T> {
  SelectionManifest({this.label, this.value, this.width, this.height});
  @required
  final String label;
  @required
  final T value;
  @required
  final double width;
  @required
  final double height;
}

class Selection<T> extends StatefulWidget {
  Selection(
      {this.key,
      this.focusNodes,
      this.focusNodeIndex,
      this.manifests,
      this.selectedValue})
      : super(key: key);
  static const String className = "Selection";

  final Key key;
  final List<FocusNode> focusNodes;
  final int focusNodeIndex;
  @required
  final List<SelectionManifest<T>> manifests;
  @required
  final List<T> selectedValue;

  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  bool _alreadyDisposed = false;
  int _focusedIndex;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusedIndex = widget.selectedValue[0]?.index ?? 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void setState(Function fn) {
    if (_alreadyDisposed) return;

    super.setState(fn);
  }

  @override
  void dispose() {
    _alreadyDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
        focusNode: widget.focusNodes[widget.focusNodeIndex],
        onFocusChange: (value) => setState(() => _focused = value),
        child: Wrap(
            children:
                List<Widget>.generate(widget.manifests.length, (int index) {
          return Container(
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              width: widget.manifests[index].width,
              height: widget.manifests[index].height,
              child: Material(
                  borderRadius: BorderRadius.circular(8.0),
                  clipBehavior: Clip.antiAlias,
                  color: _focused && (_focusedIndex ?? -1) == index
                      ? Colors.blue[100]
                      : Colors.grey[300],
                  child: Stack(children: <Widget>[
                    Container(
                        height: widget.manifests[index].height,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                  widget.selectedValue[0]?.index == index
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  color:
                                      _focused && (_focusedIndex ?? -1) == index
                                          ? Colors.blue
                                          : Colors.black),
                              Text('${widget.manifests[index].label}')
                            ])),
                    InkWell(
                        child: null,
                        onTap: () {
                          FocusScope.of(context).requestFocus(
                              widget.focusNodes[widget.focusNodeIndex]);
                          setState(() {
                            _focused = true;
                            _focusedIndex = index;
                            widget.selectedValue[0] =
                                widget.manifests[index].value;
                          });
                        })
                  ])));
        }).toList()),
        onKey: _onKey);
  }

  bool _onKey(FocusNode node, RawKeyEvent keyEvent) {
    if (node.hasFocus && ((keyEvent as RawKeyUpEvent) != null)) {
      /// move focus
      if (keyEvent.data.physicalKey == PhysicalKeyboardKey.tab) {
        if (!keyEvent.data.isShiftPressed) {
          /// next
          int next = widget.focusNodeIndex + 1;
          if (next == widget.focusNodes.length) next = 0;
          FocusScope.of(context).requestFocus(widget.focusNodes[next]);
          return true;
        } else {
          /// prev
          int prev = widget.focusNodeIndex - 1;
          if (prev < 0) prev = widget.focusNodes.length - 1;
          FocusScope.of(context).requestFocus(widget.focusNodes[prev]);
          return true;
        }
      } else if ((keyEvent.data.physicalKey == PhysicalKeyboardKey.arrowDown) ||
          (keyEvent.data.physicalKey == PhysicalKeyboardKey.arrowRight)) {
        /// switch next
        setState(() {
          bool alreadyOn =
              widget.selectedValue[0] == widget.manifests[_focusedIndex].value;
          final qty = widget.manifests.length;
          _focusedIndex++;
          if (_focusedIndex == qty) _focusedIndex = 0;
          if (alreadyOn)
            widget.selectedValue[0] = widget.manifests[_focusedIndex].value;
        });
        return true;
      } else if ((keyEvent.data.physicalKey == PhysicalKeyboardKey.arrowUp) ||
          (keyEvent.data.physicalKey == PhysicalKeyboardKey.arrowLeft)) {
        /// switch prev
        setState(() {
          bool alreadyOn =
              widget.selectedValue[0] == widget.manifests[_focusedIndex].value;
          final qty = widget.manifests.length;
          _focusedIndex--;
          if (_focusedIndex < 0) _focusedIndex = qty - 1;
          if (alreadyOn)
            widget.selectedValue[0] = widget.manifests[_focusedIndex].value;
        });
        return true;
      } else if (keyEvent.data.physicalKey == PhysicalKeyboardKey.space) {
        if (widget.selectedValue[0] != widget.manifests[_focusedIndex].value)
          setState(() =>
              widget.selectedValue[0] = widget.manifests[_focusedIndex].value);
        return true;
      }
    }
    return false;
  }
}
