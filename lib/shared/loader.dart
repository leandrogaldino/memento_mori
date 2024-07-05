import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:memento_mori/shared/app_theme.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroudColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: LoadingAnimationWidget.inkDrop(
                color: AppTheme.primaryColor,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'POR FAVOR AGUARDE',
              style: AppTheme.titleSmallStyle,
            )
          ],
        ),
      ),
    );
  }
}
