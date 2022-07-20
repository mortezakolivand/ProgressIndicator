import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:progressbar/utility/colors.dart';
import 'package:countup/countup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ProgressIndicator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _visibilyNum = 1;
  int _start = 5;
  late Timer _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        print(_start);
        if (_start == 0) {
          setState(() {
            print("00000");
            _visibilyNum = 3;
            timer.cancel();
          });
        } else if (_start == 3) {
          setState(() {
            _visibilyNum = 2;
            _start--;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FirstPart(visibilyNum: _visibilyNum),
            SecondPart(visibilyNum: _visibilyNum),
            ThirdPart(visibilyNum: _visibilyNum),
          ],
        ),
      ),
    );
  }
}

class ThirdPart extends StatelessWidget {
  const ThirdPart({
    Key? key,
    required int visibilyNum,
  }) : _visibilyNum = visibilyNum, super(key: key);

  final int _visibilyNum;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _visibilyNum == 3 ? true : false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text("All done",style: TextStyle(color: MColors.white,fontSize: 25)),
            CustomPaint(painter: DrawCircle()),
            Lottie.asset('assets/json/events.json'),
          ],
        ));
  }
}

class SecondPart extends StatelessWidget {
  const SecondPart({
    Key? key,
    required int visibilyNum,
  }) : _visibilyNum = visibilyNum, super(key: key);

  final int _visibilyNum;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visibilyNum == 2 ? true : false,
      child: CircularPercentIndicator(
        radius: 200.0,
        lineWidth: 13.0,
         progressColor: MColors.yellow,
        animation: true,
        animationDuration: 2000,
        percent: 1,
        center: Countup(
          begin: 0,
          end: 100,
          duration: Duration(seconds: 2),
          //separator: '%',
          suffix: "%",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}

class FirstPart extends StatelessWidget {
  const FirstPart({
    Key? key,
    required int visibilyNum,
  }) : _visibilyNum = visibilyNum, super(key: key);

  final int _visibilyNum;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visibilyNum == 1 ? true : false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(MColors.gray1),
            ),
          ),
          // Positioned.fill(
          //    child: Align( alignment: Alignment.center,
          //     child:
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(MColors.gray2),
            ),
          ),

          //   ),
          // ),
          //  Positioned.fill(
          //      child: Align( alignment: Alignment.center,
          //       child:
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(MColors.gray3),
              ),
            ),
          ),
          //  ),
          // ),
        ],
      ),
    );
  }
}

class DrawCircle extends CustomPainter {
  late Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = MColors.yellow
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 100.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
