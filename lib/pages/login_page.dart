import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memento_mori/controllers/login_controller.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:memento_mori/shared/messages.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final controller = GetIt.I<LoginController>();

  @override
  void initState() {
    messageListener(controller);
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    //final isPortrait = screenSize.height > screenSize.width;
    //final containerSize = isPortrait ? screenSize.width * 0.3 : screenSize.height * 0.3;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: AppTheme.gradientColor,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Login', style: AppTheme.titleStyle.copyWith(color: AppTheme.secondaryColor)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.backgroudColor,
                    ),
                    width: screenSize.width * .8,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-Mail obrigatório'),
                              Validatorless.email('E-Mail inválido'),
                            ]),
                            decoration: const InputDecoration(labelText: 'E-Mail'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          ValueListenableBuilder(
                            valueListenable: controller.obscurePassword,
                            builder: (_, value, child) {
                              return TextFormField(
                                obscureText: value,
                                controller: passwordEC,
                                validator: Validatorless.required('Senha obrigatória'),
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.toggleObscurePassword();
                                    },
                                    icon: value ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: screenSize.width * 0.8,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                final valid = formKey.currentState?.validate() ?? false;
                                if (valid) {
                                  await controller.singIn(emailEC.text, passwordEC.text).asyncLoader();
                                }
                              },
                              child: Text(
                                'Login',
                                style: AppTheme.subTitleStyle.copyWith(color: AppTheme.secondaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
