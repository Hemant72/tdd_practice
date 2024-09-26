import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tdd_practice/src/auth/presentation/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final authBloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
          ),
          ElevatedButton(
            onPressed: () {
              authBloc.add(
                CreateUserEvent(
                  name: nameController.text,
                  avatar: 'avatar',
                  createdAt: DateTime.now().toIso8601String(),
                ),
              );
            },
            child: const Text("Add User"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go("/users");
        },
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
