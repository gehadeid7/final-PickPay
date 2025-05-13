import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/core/services/get_it_service.dart';
import 'package:pickpay/core/widgets/build_appbar.dart';
import 'package:pickpay/core/widgets/app_flushbar.dart';
import 'package:pickpay/features/auth/domain/repos/auth_repo.dart';
import 'package:pickpay/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt.get<AuthRepo>()),
      child: BlocConsumer<SigninCubit, SigninState>(
        listener: (context, state) {
          if (state is SigninSuccess) {
            AppFlushbar.showSuccess(context, 'Signed in successfully');
            // Navigate if needed
            // Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else if (state is SigninFailure) {
            AppFlushbar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildAppBar(context: context, title: 'Sign in'),
            body: const SigninViewBody(),
          );
        },
      ),
    );
  }
}
