import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/l10n/l10n.dart';
import 'package:flutter_chat/login/login.dart';
import 'package:flutter_chat/registration/registration.dart';

class HomePage extends StatelessWidget {
  final AppUser authenticateduser;
  const HomePage({
    Key? key,
    required this.authenticateduser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeView(authenticateduser: authenticateduser);
  }
}

class HomeView extends StatefulWidget {
  final AppUser authenticateduser;
  const HomeView({
    Key? key,
    required this.authenticateduser,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedItem = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.contacts_rounded,
      size: 150,
    ),
    Icon(
      Icons.chat_rounded,
      size: 150,
    ),
    Icon(
      Icons.person_rounded,
      size: 150,
    ),
  ];

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
      body: Center(child: _pages.elementAt(selectedItem)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedItem,
        onTap: (value) => setState(() => selectedItem = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_rounded),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
