import 'package:flutter/material.dart';

import 'package:flutter_chat/registration/registration.dart';

class ContactPage extends StatelessWidget {
  final AppUser authenticatedUser;
  const ContactPage({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ContactView();
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This is contact page'),
    );
  }
}
