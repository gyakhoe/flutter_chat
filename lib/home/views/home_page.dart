import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/l10n/l10n.dart';
import 'package:flutter_chat/login/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<LoginBloc>(context).add(LoginRemoved());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(child: Text(l10n.homeWelcomeTitle)),
    );
  }
}
