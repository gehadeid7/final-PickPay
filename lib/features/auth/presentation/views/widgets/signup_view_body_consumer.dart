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
      listener: (context, state) async {
        if (state is SignupSuccess) {
          // After successful signup, check if the email is verified.
          final userExists = await context.read<SignupCubit>().checkIfUserExists(state.userEntity.email);

          if (userExists) {
            // If user exists and email is verified, navigate to home
            if (state.userEntity.emailVerified) {
              Navigator.pushNamed(context, '/home');
            } else {
              // Otherwise, navigate to the email verification page
              Navigator.pushNamed(context, '/verify_email');
            }
          } else {
            // If user does not exist, show an error message with Flushbar
            AppFlushbar.showError(context, 'User does not exist');
          }
        }

        if (state is SignupFailure) {
          // Show error using Flushbar instead of buildErrorBar
          AppFlushbar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading,  // Simplified condition
          child: SignUpViewBody(),
        );
      },
    );
  }
}
