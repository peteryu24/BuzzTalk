import 'package:alarm_app/src/repository/auth_repository.dart';
import 'package:alarm_app/src/view/home/my_room/my_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRoomView extends StatefulWidget {
  const MyRoomView({super.key});

  @override
  State<MyRoomView> createState() => _MyRoomViewState();
}

class _MyRoomViewState extends State<MyRoomView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyRoomViewModel(
        authRepository: context.read<AuthRepository>(),
      ),
      child: Consumer<MyRoomViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Page"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () => viewModel.logout(context),
                    child: const Text("Logout"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.deleteAccount(context),
                    child: const Text("Delete Account"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.changePassword(context),
                    child: const Text("Change Password"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
