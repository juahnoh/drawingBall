
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tilt/tilt.dart';
import '../../models/dotinfo.dart';
import 'local_utils/DrawingProvider.dart';

class DrawingPage extends StatefulWidget{
  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  double posX = 180, posY = 350;
  bool isRunning = false;
  void onStopPressed(){
    setState(() {
      isRunning = false;
    });
  }
  void onStartPressed(){
    setState(() {
      isRunning = true;
    });
  }


  @override
  Widget build(BuildContext context){
    var p = Provider.of<DrawingProvider>(context);
    return Scaffold(
      body:
        Column(
          children: [
            Flexible(
                flex: 3,
                child: IconButton(
                  iconSize: 120,
                  color: Colors.black,
                  onPressed: isRunning ? onStopPressed : onStartPressed,
                  icon: Icon(isRunning ? Icons.pause_circle_outline: Icons.play_circle_outline),
                )
            ),

            Flexible(
              flex: 5,
              child:
            StreamBuilder<GyroscopeEvent>(
              stream: SensorsPlatform.instance.gyroscopeEvents,
              builder: (context, snapshot)
              {
                if (snapshot.hasData && isRunning==true) {
                    posX = posX + (snapshot.data!.y * 40);
                    posY = posY + (snapshot.data!.x * 40);
                    p.drawStart(Offset(posX, posY));
                    p.drawing(Offset(posX, posY));
                }else{}
                return Scaffold(
                  body: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(painter: DrawingPainter(p.lines),)),
                      Transform.translate(
                      offset: Offset(posX, posY),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                      ),),
                  ]),
      );
    }
              ),
            ),
          ],
        )
    );
  }
}


class DrawingPainter extends CustomPainter{
  DrawingPainter(this.lines);
  final List<List<DotInfo>> lines;
  @override
  void paint(Canvas canvas, Size size) {
    for(var oneLine in lines){
      Color color = Colors.black;
      double size = 5;
      var l = <Offset>[];
      var p = Path();
      for(var oneDot in oneLine){
        color = oneDot.color;
        size = oneDot.size;
        l.add(oneDot.offset);
      }
      p.addPolygon(l, false);
      canvas.drawPath(p, Paint()..color = color..strokeWidth=size..strokeCap=StrokeCap.round..style=PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


