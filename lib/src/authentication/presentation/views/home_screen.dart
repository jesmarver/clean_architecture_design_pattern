import 'package:clean_architecture_design_pattern/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:clean_architecture_design_pattern/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:clean_architecture_design_pattern/src/authentication/presentation/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is UserCreated) {
        getUsers();
      }
    }, builder: (context, state) {
      return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) =>
                    AddUserDialog(nameController: nameController),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add User'),
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching Users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return ListTile(
                                leading: Image.network(user.avatar),
                                title: Text(user.name),
                                subtitle: Text(user.createdAt),
                              );
                            },
                            itemCount: state.users.length,
                          ),
                        )
                      : const SizedBox.shrink());
    });
  }
}
