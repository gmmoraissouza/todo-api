import 'package:flutter/material.dart';
import 'package:todo_api/data/repository/user_repo_impl.dart';

import '../constants/constants.dart';
import 'edit_user_screen_widgets/delete_account.dart';
import 'edit_user_screen_widgets/edit_password.dart';
import 'edit_user_screen_widgets/edit_username.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final Map<String, dynamic> user;
  final _formKey = GlobalKey<FormState>();
  final repository = UserRepoImpl();
  final _password = TextEditingController();
  final _newUsername = TextEditingController();
  final _newPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: pagePadding,
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
                  Text('ALTERAR DADOS', style: titleStyle),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EditUsername(
                      formKey: _formKey,
                      newUsername: _newUsername,
                      password: _password,
                      user: user,
                      repository: repository),
                  EditPassword(
                      formKey: _formKey,
                      password: _password,
                      newPassword: _newPassword,
                      user: user,
                      repository: repository),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              DeleteAccount(
                  formKey: _formKey,
                  password: _password,
                  user: user,
                  repository: repository)
            ],
          ),
        )),
      ),
    );
  }
}
