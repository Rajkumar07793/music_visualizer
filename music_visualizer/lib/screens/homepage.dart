import "package:flutter/material.dart";
import 'package:flutter/animation.dart';

class VisualComponent extends StatefulWidget {
  final int duration;
  final Color color;
  final bool isAnimate;
  const VisualComponent({Key key,@required this.duration, @required this.color, this.isAnimate}): super(key: key);
  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animate();
  }

  animate(){
    animationController = AnimationController(duration: Duration(milliseconds: widget.duration),vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController,curve: Curves.easeInOutCubic);
    animation = Tween<double>(begin: 0, end: 50).animate(curvedAnimation)..addListener(() {
      setState(() {

      });
    });
    animationController.forward();
    print(animation.value);
    animationController.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
      else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3,
      height: animation.value,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

