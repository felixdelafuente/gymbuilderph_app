import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/user/user_bloc.dart';
import 'package:gym_builder_app/data/models/user_model.dart';
import 'package:gym_builder_app/main.dart';
import 'package:restart_app/restart_app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.title});
  final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  late UserBloc userBloc;

  // Create controllers for the text fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the screen is disposed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        print("loading: $state");
      } else if (state is UserErrorState) {
        print("error: $state");
      } else if (state is UserLoadedState) {
        print("loaded: $state");

        List<UserModel> user = state.user;

        _firstNameController.text = user.first.firstName.toString();
        _lastNameController.text = user.first.lastName.toString();
        _emailController.text = user.first.email.toString();

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.pushNamed("menu"),
            ),
            title: Text(widget.title),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: SingleChildScrollView(
            // Use a scrollable view to avoid overflow issues
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                // Use the global key for the form
                key: _formKey,
                child: Column(
                  children: [
                    // Create a text field for the first name
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        // Validate the input value
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Create a text field for the last name
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        // Validate the input value
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Create a text field for the email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        // Validate the input value
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Create a button to save changes
                        ElevatedButton(
                          onPressed: () {
                            // Validate and submit the form
                            if (_formKey.currentState!.validate()) {
                              // Get the values from the controllers
                              String firstName = _firstNameController.text;
                              String lastName = _lastNameController.text;
                              String email = _emailController.text;

                              // Do something with the values, such as updating the user profile or sending them to a server
                              UserBloc().add(UpdateUserEvent(
                                  userId: int.parse(
                                      loginState.user!.userId.toString()),
                                  firstName: firstName,
                                  lastName: lastName,
                                  email: email));

                              // Show a success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Your changes have been saved successfully'),
                                ),
                              );
                            }
                          },
                          child: const Text('Save Changes'),
                        ),
                        // Create a button to delete account
                        ElevatedButton(
                          onPressed: () {
                            // Show a confirmation dialog before deleting the account
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text(
                                      'This will delete your account permanently'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Delete the account from the server or database
                                        UserBloc().add(DeleteUserEvent(
                                            userId: int.parse(loginState
                                                .user!.userId
                                                .toString())));

                                        // Restart app and go back to login screen
                                        Restart.restartApp();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text('Delete Account'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
      return Container();
    });
  }
}
