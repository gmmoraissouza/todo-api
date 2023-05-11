import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/entity/user.dart';
import '../../data/repository/user_repo_impl.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/input_form_widget.dart';
import '../login_screen.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController password,
    required this.user,
    required this.repository,
  }) : _formKey = formKey, _password = password;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _password;
  final Map<String, dynamic> user;
  final UserRepoImpl repository;

  @override
  Widget build(BuildContext context) {
    return DefaultButtonWidget(
      title: 'Deletar conta',
      onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return Form(
              key: _formKey,
              child: SizedBox(
                height: 250.0,
                child: Padding(
                  padding: pagePadding,
                  child: Column(
                    children: [
                      InputFormWidget(
                          obscureText: true,
                          controller: _password,
                          formEmpty: 'Informe sua senha',
                          hintText: 'Senha'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.03),
                      DefaultButtonWidget(
                        title: 'Confirmar',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final userSet = User(
                              username: user['username'],
                              password: _password.text,
                              token: user['token'],
                            );
                            await repository.deleteUser(userSet);
                            if (repository.error['message'] ==
                                'User Successfully Deleted') {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()),
                                      (route) => false);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(repository
                                      .error['message'])));
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}