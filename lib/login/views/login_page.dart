import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/home/home.dart';
import 'package:flutter_chat/l10n/l10n.dart';
import 'package:flutter_chat/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        loginRepository: LoginRepository(
          loginFirebaseProvider:
              LoginFirebaseProvider(firebaseAuth: FirebaseAuth.instance),
        ),
      ),
      child: const LoginView(),
    );
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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage(),
            ),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                l10n.loginFailureText,
                style: const TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginInitial || state is LoginFailure) {
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
