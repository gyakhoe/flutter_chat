import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/l10n/l10n.dart';
import 'package:flutter_chat/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginAppBarTitle),
      ),
      body: const Center(
        child: LoginWithGoogleButton(),
      ),
    );
  }
}

class LoginWithGoogleButton extends StatelessWidget {
  const LoginWithGoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MaterialButton(
      elevation: 5,
      color: Theme.of(context).primaryColor,
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
      },
      child: Text(
        l10n.loginButtonTitle,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
