import 'package:flutter/material.dart';
import 'package:todo_api/constants/constants.dart';
import 'package:todo_api/data/entity/user.dart';
import 'package:todo_api/data/repository/user_repo_impl.dart';
import 'package:todo_api/widgets/input_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({
    super.key,
  });

  final user = UserRepoImpl();
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: pagePadding,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.person,
                        color: primaryColor,
                        size: 40,
                      ),
                      Text('NOVA CONTA', style: titleStyle),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  InputFormWidget(
                      obscureText: false,
                      controller: _name,
                      formEmpty: 'Informe seu nome',
                      hintText: 'Nome'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  InputFormWidget(
                      obscureText: false,
                      controller: _username,
                      formEmpty: 'Informe seu usuário',
                      hintText: 'Usuário'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  InputFormWidget(
                      obscureText: false,
                      controller: _email,
                      formEmpty: 'Informe seu e-mail',
                      hintText: 'E-mail'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  InputFormWidget(
                      obscureText: true,
                      controller: _password,
                      formEmpty: 'Informe sua senha',
                      hintText: 'Senha'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final userSet = User(
                              name: _name.text,
                              password: _password.text,
                              username: _username.text,
                              email: _email.text,
                            );
                            await user.createUser(userSet);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Criar conta',
                          style: userStyle,
                        ),
                      ))
                ],
              )),
        )),
      ),
    );
  }
}
