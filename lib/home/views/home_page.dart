import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat/chat/chat.dart';
import 'package:flutter_chat/contact/contact.dart';
import 'package:flutter_chat/home/home.dart';
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
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: HomeView(
        authenticateduser: authenticateduser,
      ),
    );
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
      body: _homeBodyBuilder(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedItem,
        onTap: _onBottomNavTapped,
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

  Widget _homeBodyBuilder(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeContact) {
          return ContactPage(authenticatedUser: widget.authenticateduser);
        } else if (state is HomeChat) {
          return ChatPage(
            authenticatedUser: widget.authenticateduser,
          );
        } else {
          return Center(
            child: Text('You are ${widget.authenticateduser.displayName}'),
          );
        }
      },
    );
  }

  void _onBottomNavTapped(int value) {
    if (value == 0) {
      BlocProvider.of<HomeBloc>(context).add(HomeContactTapped());
    } else if (value == 1) {
      BlocProvider.of<HomeBloc>(context).add(HomeChatTapped());
    } else {
      BlocProvider.of<HomeBloc>(context).add(HomeProfileTapped());
    }
    setState(() => selectedItem = value);
  }
}
