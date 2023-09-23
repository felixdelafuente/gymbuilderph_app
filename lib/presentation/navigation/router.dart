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
import 'package:gym_builder_app/presentation/screens/admin_dashboard_screen.dart';
import 'package:gym_builder_app/presentation/screens/admin_menu_screen.dart';
import 'package:gym_builder_app/presentation/screens/admin_order_screen.dart';
import 'package:gym_builder_app/presentation/screens/admin_product_screen.dart';
import 'package:gym_builder_app/presentation/screens/admin_user_screen.dart';
import 'package:gym_builder_app/presentation/screens/information_screen.dart';
import 'package:gym_builder_app/presentation/screens/cart_screen.dart';
import 'package:gym_builder_app/presentation/screens/checkout_screen.dart';
import 'package:gym_builder_app/presentation/screens/order_screen.dart';
import 'package:gym_builder_app/presentation/screens/login_screen.dart';
import 'package:gym_builder_app/presentation/screens/main_menu_screen.dart';
import 'package:gym_builder_app/presentation/screens/products_screen.dart';
import 'package:gym_builder_app/presentation/screens/user_screen.dart';

const String loggedInKey = 'LoggedIn';

class MyRouter {
  final LoginState loginInfo;

  MyRouter(this.loginInfo);

  String title = "Gym Builder";

  // int int.parse(loginState.user?.admin.toString() ?? "0") = int.parse(loginState.user?.admin.toString() ?? "0");
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
      // CUSTOMER ROUTES
      GoRoute(
          name: 'menu',
          path: '/menu',
          pageBuilder: (context, state) {
            if (loginInfo.user!.admin! == "1") {
              return MaterialPage(
                  child: AdminMenuScreen(
                title: title,
              ));
            } else {
              return const MaterialPage(
                  child: MainMenuScreen(
                title: "Gym Builder",
              ));
            }
          }),
      GoRoute(
          name: 'menu',
          path: '/menu',
          pageBuilder: (context, state) {
            return const MaterialPage(
                child: MainMenuScreen(
              title: "Gym Builder",
            ));
          }),
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
              child: const ProductsScreen(
                title: "Gym Builder Products",
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
              child: const CartScreen(
                title: "Your Cart",
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
              child: const CheckoutScreen(
                title: "Checkout",
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
          name: 'user',
          path: '/user',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) => UserBloc()..add(LoadUserEvent()),
              child: const ProfileScreen(
                title: "Profile",
              ),
            ));
          }),
      GoRoute(
          name: 'about',
          path: '/about',
          pageBuilder: ((context, state) {
            return const MaterialPage(
                child: InformationScreen(
              title: "About",
            ));
          })),
      // ADMIN ROUTES
      GoRoute(
          name: 'admin-menu',
          path: '/admin-menu',
          pageBuilder: (context, state) {
            return const MaterialPage(
                child: AdminMenuScreen(
              title: "Gym Builder Admin",
            ));
          }),
      GoRoute(
          name: 'admin-dashboard',
          path: '/admin-dashbaord',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => OrderBloc()..add(LoadAllOrderEvent()),
              ),
              BlocProvider(
                create: (context) => ProductsBloc()..add(LoadProductsEvent()),
              ),
            ], child: const AdminDashboardScreen()));
          })),
      GoRoute(
          name: 'admin-products',
          path: '/admin-products',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => ProductsBloc()..add(LoadProductsEvent()),
              ),
              BlocProvider(
                create: (context) => CartBloc()..add(LoadCartEvent()),
              ),
            ], child: const AdminProductsScreen()));
          })),
      GoRoute(
          name: 'admin-order',
          path: '/admin-order',
          pageBuilder: ((context, state) {
            return MaterialPage(
                child: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => ProductsBloc()..add(LoadProductsEvent()),
              ),
              BlocProvider(
                create: (context) => OrderBloc()..add(LoadOrderEvent()),
              )
            ], child: const AdminOrderScreen()));
          })),
      GoRoute(
          name: 'admin-users',
          path: '/admin-users',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
                    create: (context) => UserBloc()..add(LoadAllUserEvent()),
                    child: const AdminUserScreen()));
          }),
    ],
    // redirect: (context, state) {
    //   // bool isAuthenticating = [
    //   //   '/',
    //   // ].contains(state.matchedLocation);

    //   final loggedIn = loginInfo.loggedIn;

    //   if (loggedIn == true) {
    //     return '/menu';
    //   } else {
    //     return '/';
    //   }
    // }
  );
}
