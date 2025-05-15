import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/signin_view_body_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog when going back
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to exit the app?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false); // No to exit
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true); // Yes to exit
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false; // If clicked elsewhere, cancel the operation
      },
      child: BlocProvider(
        create: (context) => SigninCubit(
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          appBar: buildAppBar(context: context, title: 'Sign In'),
          body: SigninViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
