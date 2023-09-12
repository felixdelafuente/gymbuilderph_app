import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/data_state.dart';
import 'package:gym_builder_app/bloc/login/login_bloc.dart';
import 'package:gym_builder_app/bloc/login/login_event.dart';
import 'package:gym_builder_app/bloc/login/login_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A controller to get the user input from the email text field
  final TextEditingController _emailController = TextEditingController();

  // A controller to get the user input from the password text field
  final TextEditingController _passwordController = TextEditingController();

  // A boolean value to indicate whether the password is visible or not
  bool _passwordVisible = false;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
    // Initialize the password visibility to false
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is DataLoading) {
          print("loading");
        } else if (state is DataError) {
          print("error");
        } else if (state is DataSuccess) {
          context.goNamed("menu");
          Provider.of<LoginState>(context, listen: false).loggedIn = true;
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // A widget for the dumbbell icon of 120x120 pixels
                const Icon(
                  Icons.fitness_center,
                  size: 120,
                  color: Colors.blue,
                ),
                // A widget for the email text field that has a placeholder of Email
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                // A widget for the password text field that has a placeholder of Password
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible, // Hide or show the password
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      // A widget for the hide/show icon in the text field
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on the password visibility, choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Toggle the password visibility
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // A widget for the Log In button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Perform the login logic here
                      // print('Email: ${_emailController.text}');
                      // print('Password: ${_passwordController.text}');
                      _loginBloc.add(LoginUserEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: const Text('Log In'),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // launch("http://gymbuilderph.com/register");
                //     },
                //     child: const Text('Register'),
                //   ),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
