import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation Intro',
      debugShowCheckedModeBanner: false,
      home: LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller,curve: Curves.fastOutSlowIn);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

   animation.addListener(() {
     print(animation.value);
   });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: IsaiasTransition(child: LogoWidget(), animation: animation));
  }
}

/*class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo(Animation<double> animation): super(listenable: animation);
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation= listenable;
     return Center(
       child: Container(
         height: animation.value,
         width: animation.value,
         child: FlutterLogo(),
       ),
     );
  }

} */

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(),
    );
  }
}

class IsaiasTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final sizeTween= Tween<double>(begin: 0,end: 300);
  final opacyteTween= Tween<double>(begin: 0.1,end:1);
  IsaiasTransition({this.child, this.animation});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: opacyteTween.evaluate(animation).clamp(0, 1.0),
            child: Container(
              height: sizeTween.evaluate(animation),
              width: sizeTween.evaluate(animation),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}
