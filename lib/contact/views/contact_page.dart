import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_chat/contact/bloc/contact_bloc.dart';
import 'package:flutter_chat/contact/data/provider/contact_firebase_provider.dart';
import 'package:flutter_chat/contact/data/repository/contact_repository.dart';
import 'package:flutter_chat/l10n/l10n.dart';
import 'package:flutter_chat/registration/registration.dart';

class ContactPage extends StatelessWidget {
  final AppUser authenticatedUser;
  const ContactPage({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactBloc(
        ContactRepository(
          contactFirebaseProvider:
              ContactFirebaseProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(ContactListRequested(loginUID: authenticatedUser.uid)),
      child: ContactView(
        loginUID: authenticatedUser.uid,
      ),
    );
  }
}

class ContactView extends StatelessWidget {
  final String loginUID;
  const ContactView({
    Key? key,
    required this.loginUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoadInprogress) {
            return const CircularProgressIndicator();
          } else if (state is ContactLoadFailure) {
            return const Text('Unable to load contacts');
          } else if (state is ContactLoadSuccess) {
            return _contactListView(contacts: state.contacts);
          }
          return Text('${l10n.undefinedStateText} ${state.runtimeType}');
        },
      ),
    );
  }

  Widget _contactListView({required List<AppUser> contacts}) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        final contact = contacts.elementAt(index);
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(contact.photoUrl),
          ),
          title: Text(contact.displayName),
          subtitle: Text(contact.email),
        );
      },
    );
  }
}
