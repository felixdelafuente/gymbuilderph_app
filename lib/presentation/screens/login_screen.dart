import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/data_state.dart';
import 'package:gym_builder_app/bloc/login/login_bloc.dart';
import 'package:gym_builder_app/bloc/login/login_event.dart';
import 'package:gym_builder_app/bloc/login/login_state.dart';
import 'package:gym_builder_app/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

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
                Container(
                  width: 120,
                  height: 120,
                  child: Image.asset('images/logo.png'),
                ),
                SizedBox(
                  height: 16,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 4, 16),
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(
                          Uri.parse("http://gymbuilderph.com/forgot-password"));
                    },
                    child: Container(
                      alignment: Alignment
                          .centerLeft, // align the container on the left
                      child: const Text(
                        'Forgot Password?', // the text to display
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey), // align the text on the left
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Perform the login logic here
                        _loginBloc.add(LoginUserEvent(
                            email: _emailController.text,
                            password: _passwordController.text));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        launchUrl(
                            Uri.parse("http://gymbuilderph.com/register"));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      child: const Text('Register'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
