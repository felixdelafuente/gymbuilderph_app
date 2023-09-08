import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/address/address_bloc.dart';
import 'package:gym_builder_app/bloc/cart/cart_bloc.dart';
import 'package:gym_builder_app/bloc/login/login_bloc.dart';
import 'package:gym_builder_app/bloc/login/login_state.dart';
import 'package:gym_builder_app/bloc/order/order_bloc.dart';
import 'package:gym_builder_app/bloc/products/products_bloc.dart';
import 'package:gym_builder_app/bloc/user/user_bloc.dart';
import 'package:gym_builder_app/presentation/screens/information_screen.dart';
import 'package:gym_builder_app/presentation/screens/cart_screen.dart';
import 'package:gym_builder_app/presentation/screens/checkout_screen.dart';
import 'package:gym_builder_app/presentation/screens/order_screen.dart';
import 'package:gym_builder_app/presentation/screens/login_screen.dart';
import 'package:gym_builder_app/presentation/screens/main_menu_screen.dart';
import 'package:gym_builder_app/presentation/screens/products_screen.dart';
import 'package:gym_builder_app/presentation/screens/profile_screen.dart';

const String loggedInKey = 'LoggedIn';

class MyRouter {
  final LoginState loginInfo;

  MyRouter(this.loginInfo);

  String title = "Gym Builder PH";
  late final goRouter = GoRouter(
    refreshListenable: loginInfo,
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'login',
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
            child: BlocProvider(
          create: (context) => LoginBloc(),
          child: const LoginScreen(),
        )),
      ),
      GoRoute(
        name: 'menu',
        path: '/menu',
        pageBuilder: (context, state) => MaterialPage(
            child: MainMenuScreen(
          title: title,
        )),
      ),
      GoRoute(
          name: 'products',
          path: '/products',
          // pageBuilder: ((context, state) {
          //   return const MaterialPage(
          //       child: ProductsScreen(
          //     title: title,
          //   ));
          // }
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductsBloc()..add(LoadProductsEvent()),
                ),
                BlocProvider(
                  create: (context) => CartBloc()..add(LoadCartEvent()),
                ),
              ],
              child: ProductsScreen(
                title: title,
              ),
            ));
          })),
      GoRoute(
          name: 'cart',
          path: '/cart',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductsBloc()..add(LoadProductsEvent()),
                ),
                BlocProvider(
                  create: (context) => CartBloc()..add(LoadCartEvent()),
                )
              ],
              child: CartScreen(
                title: title,
              ),
            ));
          })),
      GoRoute(
          name: 'checkout',
          path: '/checkout',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductsBloc()..add(LoadProductsEvent()),
                ),
                BlocProvider(
                  create: (context) => CartBloc()..add(LoadCartEvent()),
                ),
                BlocProvider(
                  create: (context) => AddressBloc()..add(LoadAddressEvent()),
                ),
                BlocProvider(
                  create: (context) => OrderBloc(),
                )
              ],
              child: CheckoutScreen(
                title: title,
              ),
            ));
          })),
      GoRoute(
          name: 'order',
          path: '/order',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProductsBloc()..add(LoadProductsEvent()),
                ),
                BlocProvider(
                  create: (context) => OrderBloc()..add(LoadOrderEvent()),
                )
              ],
              child: const OrderScreen(
                title: "Order Status",
              ),
            ));
          })),
      GoRoute(
          name: 'about',
          path: '/about',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: InformationScreen(
              title: title,
            ));
          })),
      GoRoute(
        name: 'profile',
        path: '/profile',
        pageBuilder: (context, state) => MaterialPage(
            child: BlocProvider(
          create: (context) => UserBloc()..add(LoadUserEvent()),
          child: const ProfileScreen(
            title: "Profile",
          ),
        )),
      ),
    ],
    // redirect: (context, state) {
    //   bool isAuthenticating = [
    //     '/',
    //   ].contains(state.matchedLocation);

    //   final loggedIn = loginInfo.loggedIn;

    //   if (loggedIn == true) {
    //     return '/menu';
    //   } else {
    //     return '/';
    //   }
    // }
  );
}
