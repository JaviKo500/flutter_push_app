import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
          ( NotificationsBloc bloc ) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text( 
                'Status permissions',
                style: TextStyle()
              ),
              Text( 
                bloc.state.status.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color:  bloc.state.status == AuthorizationStatus.authorized
                    ? Colors.greenAccent[200]
                    : Colors.redAccent[100],
                )
              ),
            ],
          )
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermissions();
            }, 
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const _HomeView(),
    );
  }
}



class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) {
        return const ListTile();
      },
    );
  }
}