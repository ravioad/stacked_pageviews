import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({Key key, this.delay, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimProps>()
      ..add(AnimProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AnimProps.translateY, Tween(begin: 120.0, end: 0.0));
    return PlayAnimation<MultiTweenValues<AnimProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(milliseconds: 500),
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimProps.opacity),
        child: Transform.translate(
          offset: Offset(0, value.get(AnimProps.translateY)),
          child: child,
        ),
      ),
    );
  }
}
