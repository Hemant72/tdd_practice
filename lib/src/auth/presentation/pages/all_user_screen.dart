import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_practice/src/auth/presentation/bloc/auth_bloc.dart';

class AllScreenUsers extends StatefulWidget {
  const AllScreenUsers({super.key});

  @override
  State<AllScreenUsers> createState() => _AllScreenUsersState();
}

class _AllScreenUsersState extends State<AllScreenUsers> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: Column(
        children: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetingUser) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(state.users[index].name),
                      subtitle: Text(state.users[index].createdAt),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
