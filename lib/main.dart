import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/login/login_state.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/presentation/navigation/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late LoginState loginState;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loginState = LoginState(await SharedPreferences.getInstance());
  // loginState.checkLoggedIn();

  await Future.delayed(const Duration(milliseconds: 500));

  return runApp(MyApp(loginState: loginState));
}

class MyApp extends StatelessWidget {
  final LoginState loginState;

  const MyApp({Key? key, required this.loginState}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false, create: (BuildContext createContext) => loginState),
        Provider<MyRouter>(
          lazy: false,
          create: (BuildContext createContext) => MyRouter(loginState),
        ),
      ],
      child: Builder(builder: (context) {
        final router = Provider.of<MyRouter>(context, listen: false).goRouter;
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CartBloc()..add(LoadCartEvent()),
              ),
              BlocProvider(
                create: (context) => OrderBloc()..add(LoadOrderEvent()),
              )
            ],
            child: MaterialApp.router(
              routeInformationProvider: router.routeInformationProvider,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              title: 'Gym Builder PH',
              theme: ThemeData(primaryColor: Colors.black),
              builder: EasyLoading.init(),
            ));
      }),
    );
  }
}
