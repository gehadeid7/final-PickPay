import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pickpay/core/widgets/app_flushbar.dart';
import 'package:pickpay/features/auth/presentation/cubits/signup_cubits/signup_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/sign_up_view_body.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          // Navigate based on email verification status
          if (state.userEntity.emailVerified) {
            Navigator.pushNamed(context, '/home');
          } else {
            Navigator.pushNamed(context, '/verify_email');
          }
        }

        if (state is SignupFailure) {
          AppFlushbar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,
          child: const SignUpViewBody(),
        );
      },
    );
  }
}
