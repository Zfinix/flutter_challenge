import 'package:flutter/widgets.dart';
import 'package:flutter_challenge/core/utils/constants.dart';

/// Recreates a touchable opacity from React Native.
/// On tap down, the opacity of thecchild is decreased, dimming it.
/// Use this in place of a Container and it will include
/// tap events.
///
/// [child] (required) is what will be displayed
/// within the touchable highlight on top of the background color.
/// [onTap] is the callback which will execute when tapped.
/// [onLongPress] callback executed on long press event.
/// [width] width supplied to the enclosing container.
/// [height] height supplied to the enclosing container
/// [decoration] decoration supplied to the enclosing container.
class TouchableOpacity extends StatefulWidget {
  const TouchableOpacity({
    this.child,
    this.onTap,
    this.onLongPress,
    this.decoration,
    this.width,
    this.height,
    this.opacity,
    super.key,
    this.behavior = HitTestBehavior.opaque,
    this.disabled = false,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  final Widget? child;
  final double? width;
  final double? opacity;
  final double? height;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final BoxDecoration? decoration;
  final HitTestBehavior behavior;
  final bool disabled;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;

  @override
  TouchableOpacityState createState() => TouchableOpacityState();
}

class TouchableOpacityState extends State<TouchableOpacity> {
  bool isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        behavior: widget.behavior,
        onTapDown: (tapDownDetails) {
          if (widget.disabled) {
            return;
          }

          setState(() {
            isTappedDown = true;
          });

          widget.onTapDown?.call();
        },
        onTapUp: (tapUpDetails) {
          setState(() {
            isTappedDown = false;
          });

          widget.onTapUp?.call();
        },
        onTap: widget.disabled ? null : widget.onTap,
        onLongPress: widget.disabled ? null : widget.onLongPress,
        child: AnimatedOpacity(
          opacity: widget.opacity ?? (isTappedDown ? 0.6 : 1.0),
          duration: kAnimationDuration,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: widget.decoration,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
