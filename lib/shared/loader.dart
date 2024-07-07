// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:memento_mori/shared/app_theme.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required String? message,
  }) : _message = message;

  final String? _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroudColor.withOpacity(.9), // Fundo completamente transparente
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16), // Espaçamento interno para o conteúdo
          decoration: BoxDecoration(
            color: AppTheme.backgroudColor, // Cor de fundo branca apenas para este Container
            borderRadius: BorderRadius.circular(16), // Opcional: bordas arredondadas
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.inkDrop(
                color: AppTheme.primaryColor,
                size: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(_message ?? 'Aguarde um momento',
                  style: AppTheme.subTitleStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
