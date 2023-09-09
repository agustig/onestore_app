import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/presentation/pages/splash/widgets/splash_painter.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/images.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: ColorResources.getPrimary(context),
            child: CustomPaint(
              painter: SplashPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Images.splashLogo,
                  height: 250.0,
                  fit: BoxFit.scaleDown,
                  width: 250.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
