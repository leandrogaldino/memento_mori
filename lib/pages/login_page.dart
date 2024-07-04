import 'package:flutter/material.dart';
import 'package:memento_mori/services/firebase_auth_service.dart';
import 'package:memento_mori/services/firebase_firestore_service.dart';
import 'package:memento_mori/shared/app_theme.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final documentEC = TextEditingController();
  final accessCodeEC = TextEditingController();

  @override
  void dispose() {
    documentEC.dispose();
    accessCodeEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: screenSize.height),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              constraints: BoxConstraints(maxWidth: screenSize.width * 0.8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text('Login', style: AppTheme.titleStyle),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: documentEC,
                      validator: Validatorless.multiple([
                        Validatorless.required('CPF obrigatório'),
                        Validatorless.cpf('CPF inválido'),
                      ]),
                      decoration: const InputDecoration(label: Text('CPF')),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: accessCodeEC,
                      validator: Validatorless.required('Código de acesso obrigatório'),
                      decoration: const InputDecoration(label: Text('Código de Acesso')),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: screenSize.width * 0.8,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          //TODO Implementar botão login
                          //Ao clicar, deve-se verificar se há internet, se não houver deve vir um SnackBar dizendo que precisa de acesso,
                          // caso haja internet entao deve bater no firestore, verificar se ha algum usuario que tenha o CPF e código de acesso digitado,
                          //se tiver entao salva os dados no SecureStorage e entra, se não tiver entao deve vir um SnackBar dizendo que o usuário não existe
                          //ou se a senha está incorreta.

                          var auth = FirebaseAuthService();
                          var cred = await auth.signIn(email: 'leandrocgaldino@gmail.com', password: '45789510');

                          var firebase = FirebaseFirestoreService();
                          await firebase.save(collection: 'users', document: '1', data: {'name': 'leandro', 'document': '01653915102', 'managerid': '1523', 'authid': '1'});
                          //await service.signIn(email: 'leandrocgaldino@gmail.com', password: '45789510d');
                        },
                        child: const Text('ENTRAR'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
