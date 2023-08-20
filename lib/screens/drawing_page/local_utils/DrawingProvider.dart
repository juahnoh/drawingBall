
import 'package:flutter/material.dart';
import '../../../models/dotinfo.dart';

class DrawingProvider extends ChangeNotifier{

  final lines = <List<DotInfo>>[];

  double size =5;

  Color color = Colors.black;

  void drawStart(Offset offset){
    var oneLine = <DotInfo>[];
    oneLine.add(DotInfo(offset, size, color));
    lines.add(oneLine);
  }
  void drawing(Offset offset){
    lines.last.add(DotInfo(offset, size, color));
    notifyListeners();
  }


}