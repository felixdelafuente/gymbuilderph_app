import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_builder_app/bloc/user/user_bloc.dart';
import 'package:gym_builder_app/data/models/user_model.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // Define a function that returns a list of data columns for the table
    List<DataColumn> getDataColumns() {
      return [
        const DataColumn(label: Text('ID')),
        const DataColumn(label: Text('Name')),
        const DataColumn(label: Text('Email')),
        const DataColumn(label: Text('Admin')),
        const DataColumn(label: Text('Verified')),
      ];
    }

    // Define a function that returns a list of data rows for the table
    List<DataRow> getDataRows(List<UserModel> userList) {
      return userList.map((user) {
        return DataRow(cells: [
          DataCell(Text(user.userId.toString())),
          DataCell(
              Text("${user.firstName.toString()} ${user.lastName.toString()}")),
          DataCell(Text(user.email.toString())),
          DataCell(Text(user.admin == 1 ? "Admin" : "Customer")),
          DataCell(Text(user.verified == 1 ? "Verified" : "Not Verified")),
        ]);
      }).toList();
    }

    // Return a widget that displays the table in a scrollable view
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadingState) {
        print("loading: $state");
      } else if (state is UserErrorState) {
        print("error: $state");
      } else if (state is AllUserLoadedState) {
        print("loaded: $state");

        List<UserModel> userList = state.user;

        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => context.goNamed('menu'),
            ),
            title: const Text("Users"),
            centerTitle: true,
            backgroundColor: const Color(0xff2b2b2b),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: getDataColumns(),
              rows: getDataRows(userList),
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
