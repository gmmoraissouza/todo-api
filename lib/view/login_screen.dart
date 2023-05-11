import 'package:flutter/material.dart';
import 'package:todo_api/constants/constants.dart';
import 'package:todo_api/data/repository/user_repo_impl.dart';
import 'package:todo_api/view/signup_screen.dart';
import 'package:todo_api/widgets/default_button_widget.dart';
import 'package:todo_api/widgets/input_form_widget.dart';

import '../data/entity/user.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = UserRepoImpl();

  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();

  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.list_alt_outlined,
                        color: primaryColor,
                        size: 40,
                      ),
                      Text('TODO API', style: titleStyle),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  InputFormWidget(
                      obscureText: false,
                      controller: _username,
                      formEmpty: 'Informe seu usuário',
                      hintText: 'Usuário'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  InputFormWidget(
                      obscureText: true,
                      controller: _password,
                      formEmpty: 'Informe sua senha',
                      hintText: 'Senha'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: DefaultButtonWidget(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final userSet = User(
                                username: _username.text,
                                password: _password.text);
                            await user.loginUser(userSet);
                            if (user.userData['message'] == null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        user: user.userData,
                                      )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(user.userData['message'])));
                            }
                          }
                        },
                        title: 'Entrar'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não possui uma conta? '),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SignUpScreen())),
                  child: const Text(
                    'Criar agora',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: primaryColor),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
