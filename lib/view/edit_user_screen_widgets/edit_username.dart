import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/entity/user.dart';
import '../../data/repository/user_repo_impl.dart';
import '../../widgets/default_button_widget.dart';
import '../../widgets/icon_edit_data_widget.dart';
import '../../widgets/input_form_widget.dart';
import '../home_screen.dart';

class EditUsername extends StatelessWidget {
  const EditUsername({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController newUsername,
    required TextEditingController password,
    required this.user,
    required this.repository,
  }) : _formKey = formKey, _newUsername = newUsername, _password = password;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _newUsername;
  final TextEditingController _password;
  final Map<String, dynamic> user;
  final UserRepoImpl repository;

  @override
  Widget build(BuildContext context) {
    return IconEditDataWidget(
      icon: Icons.person,
      title: 'Usuário',
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SizedBox(
                  height: 250.0,
                  child: Padding(
                    padding: pagePadding,
                    child: Column(
                      children: [
                        InputFormWidget(
                            obscureText: false,
                            controller: _newUsername,
                            formEmpty: 'Informe seu novo usuário',
                            hintText: 'Novo usuário'),
                        SizedBox(
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.01),
                        InputFormWidget(
                            obscureText: true,
                            controller: _password,
                            formEmpty: 'Informe sua senha',
                            hintText: 'Senha'),
                        SizedBox(
                            height: MediaQuery.of(context)
                                .size
                                .height *
                                0.03),
                        DefaultButtonWidget(
                          onPressed: () async {
                            if (_formKey.currentState!
                                .validate()) {
                              final userSet = User(
                                username: user['username'],
                                password: _password.text,
                                token: user['token'],
                              );
                              await repository.updateUser(
                                userSet,
                                _newUsername.text,
                                _password.text,
                              );
                              if (repository.error['message'] ==
                                  'User/password Successfully Updated') {
                                final userSet = User(
                                    password: _password.text,
                                    username: _newUsername.text);
                                await repository
                                    .loginUser(userSet);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            HomeScreen(
                                              user: repository
                                                  .userData,
                                            )),
                                        (route) => false);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                    content: Text(repository
                                        .error['message'])));
                              }
                            }
                          },
                          title: 'Alterar usuário',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
