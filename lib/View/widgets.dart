import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/View/colors.dart';


class MyIconButton extends StatelessWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
    required this.onClickAction,
  }) : super(key: key);

  final IconData icon;
  final Function onClickAction;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.transparent.withOpacity(0.2)),
        // overlayColor:MaterialStateProperty.all<Color>(Colors.grey  ),
        shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
      ),
      onPressed: () => onClickAction(),
      child: Icon(
        icon,
        color: purpleTextColor,
      ),
    );
  }
}

/////////////////////////////////////////////////////

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Image.asset(
            "images/mountain.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: -5,
          top: 250,
          child: Image.asset(
            scale: 1.5,
            "images/Cloud.png",
          ),
        ),
        Positioned(
          right: 20,
          bottom: 200,
          child: Image.asset(
            scale: 2,
            "images/Cloud1.png",
          ),
        ),
        Positioned(
          bottom: 250,
          child: Image.asset(
            scale: 1.5,
            "images/Cloud1.png",
          ),
        ),
      ],
    );
  }
}
//////////////////

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppBar({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.iconLeading,
    required this.iconAction,
    required this.function,
  });
  final double screenWidth;
  final String title;
  final IconData? iconLeading;
  final IconData? iconAction;
  final Function function;

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      elevation: 0,
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        title.tr,
        style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: purpleTextColor),
      ),
      leading: iconLeading == null
          ? const SizedBox.shrink()
          : MyIconButton(icon: iconLeading!, onClickAction: function),
      actions: [
        if (iconAction == null)
          const SizedBox.shrink()
        else
          MyIconButton(icon: iconAction!, onClickAction: function),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
      AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    required this.child,
    required this.shakeOffset,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(minutes: 20),
  }) : super(key: key);
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // 1. return an AnimatedBuilder
    return AnimatedBuilder(
      // 2. pass our custom animation as an argument
      animation: animationController,
      // 3. optimization: pass the given child as an argument
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          // 4. apply a translation as a function of the animation value
          offset: Offset(sineValue * widget.shakeOffset, 0),
          // 5. use the child widget
          child: child,
        );
      },
    );
  }
}
