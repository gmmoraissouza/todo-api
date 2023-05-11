import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/entity/user.dart';
import '../../data/repository/user_repo_impl.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/icon_edit_data_widget.dart';
import '../../widgets/input_form_widget.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController password,
    required TextEditingController newPassword,
    required this.user,
    required this.repository,
  }) : _formKey = formKey, _password = password, _newPassword = newPassword;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _password;
  final TextEditingController _newPassword;
  final Map<String, dynamic> user;
  final UserRepoImpl repository;

  @override
  Widget build(BuildContext context) {
    return IconEditDataWidget(
      icon: Icons.password,
      title: 'Senha',
      onTap: () => showModalBottomSheet(
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
                          height:
                          MediaQuery.of(context).size.height *
                              0.01),
                      InputFormWidget(
                          obscureText: true,
                          controller: _newPassword,
                          formEmpty: 'Informe sua nova senha',
                          hintText: 'Nova senha'),
                      SizedBox(
                          height:
                          MediaQuery.of(context).size.height *
                              0.03),
                      DefaultButtonWidget(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final userSet = User(
                              username: user['username'],
                              password: _password.text,
                              token: user['token'],
                            );
                            await repository.updateUser(
                              userSet,
                              user['username'],
                              _newPassword.text,
                            );
                            if (repository.error['message'] ==
                                'User/password Successfully Updated') {
                              _password.text = '';
                              _newPassword.text = '';
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  content: Text(repository
                                      .error['message'])));
                            }
                          }
                        },
                        title: 'Alterar senha',
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