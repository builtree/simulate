import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:simulate/src/data/simulations.dart';
import 'package:provider/provider.dart';

class AlgorithmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Simulations>(context);
    ScreenUtil.init(context);
    return Container(
      child: GridView.count(
        crossAxisCount: (ScreenUtil.screenWidthDp < 600)
            ? 2
            : (ScreenUtil.screenWidthDp / 200).floor(),
          children: appState.algorithms),
    );
  }
}
