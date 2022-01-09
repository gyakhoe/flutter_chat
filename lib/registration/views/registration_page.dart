import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/home/home.dart';
import 'package:flutter_chat/l10n/l10n.dart';

import 'package:flutter_chat/registration/bloc/registration_bloc.dart';
import 'package:flutter_chat/registration/registration.dart';

class RegistrationPage extends StatelessWidget {
  final AppUser authenticatedUser;
  const RegistrationPage({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        registrationRepository: RegistrationRepository(
          registrationFirebaseProvider: RegistrationFirebaseProvider(
            firestore: FirebaseFirestore.instance,
          ),
        ),
      )..add(
          RegistrationDetailRequested(
            uid: authenticatedUser.uid,
          ),
        ),
      child: RegistrationView(authenticatedUser: authenticatedUser),
    );
  }
}

class RegistrationView extends StatelessWidget {
  final AppUser authenticatedUser;

  const RegistrationView({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: _registrationListener,
          buildWhen: (prev, current) {
            if (current is RegistrationActionFailure ||
                current is RegistrationActionError) {
              return false;
            }
            return true;
          },
          builder: _registrationBuilder,
        ),
      ),
    );
  }

  void _registrationListener(BuildContext context, RegistrationState state) {
    final l10n = context.l10n;
    if (state is RegistrationActionFailure) {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegistrationDetailUpdated(user: authenticatedUser),
      );
    } else if (state is RegistrationActionError) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.counterAppBarTitle),
        ),
      );
    }
  }

  Widget _registrationBuilder(BuildContext context, RegistrationState state) {
    final l10n = context.l10n;
    if (state is RegistrationInprogress) {
      return const CircularProgressIndicator();
    } else if (state is RegistrationUpdateSuccess) {
      return HomePage(authenticateduser: state.user);
    } else if (state is RegistrationDetailRequestSuccess) {
      return HomePage(authenticateduser: state.user);
    }

    return Text('${l10n.undefinedStateText} ${state.runtimeType}');
  }
}
