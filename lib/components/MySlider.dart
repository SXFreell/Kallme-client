import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef _BaseFunction<T> = void Function(T o);

class MySlider extends StatefulWidget {
  final double actionsWidth;
  final List<Widget> actions;
  final Widget child;
  final Decoration? decoration;
  final VoidCallback? actionsWillShow;
  final _BaseFunction<VoidCallback>? exportHideActions;

  const MySlider({
    super.key,
    required this.actionsWidth,
    required this.actions,
    required this.child,
    this.decoration,
    this.actionsWillShow,
    this.exportHideActions,
  });

  @override
  State<StatefulWidget> createState() => _MySlider();
}

class _MySlider extends State<MySlider> with TickerProviderStateMixin {
  double _translateX = 0;
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: -widget.actionsWidth,
      upperBound: 0,
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        _translateX = _controller.value;
        setState(() {});
      });
    if (widget.exportHideActions != null) {
      widget.exportHideActions!(_hide);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.actions,
          )),
          GestureDetector(
            onHorizontalDragUpdate: (v) {
              _onHorizontalDragUpdate(v);
            },
            onHorizontalDragEnd: (v) {
              _onHorizontalDragEnd(v);
            },
            child: Transform.translate(
                offset: Offset(_translateX, 0),
                child: Row(
                  children: [
                    Expanded(flex: 1, child: widget.child),
                  ],
                )),
          )
        ],
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _translateX =
        (_translateX + details.delta.dx).clamp(-widget.actionsWidth, 0.0);
    setState(() {});
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _controller.value = _translateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      _hide();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      _show();
    } else {
      if (_translateX.abs() > widget.actionsWidth / 2) {
        _show();
      } else {
        _hide();
      }
    }
  }

  void _show() {
    if (widget.actionsWillShow != null) {
      widget.actionsWillShow!();
    }
    if (_translateX != -widget.actionsWidth) {
      _controller.animateTo(-widget.actionsWidth);
    }
  }

  void _hide() {
    if (_translateX != 0) {
      _controller.animateTo(0);
    }
  }
}

// class MySlider extends StatefulWidget {
//   const MySlider({
//     super.key,
//     required this.child,
//   });

//   final Widget child;

//   @override
//   State<StatefulWidget> createState() => _MySlider();
// }

// class _MySlider extends State<MySlider> {
//   double _left = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: (DragUpdateDetails e) {
//         setState(() {
//           _left += e.delta.dx;
//         });
//       },
//       child: Stack(
//         children: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//           ),
//           Positioned(
//             left: _left,
//             top: 0,
//             child: widget.child,
//           )
//         ],
//       ),
//     );
//   }
// }

