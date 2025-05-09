import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/auth/presentation/cubits/verify_email_state.dart/verify_email_cubit.dart';

class VerifyEmailview extends StatelessWidget {
  const VerifyEmailview({super.key});

  static const routeName = 'verify_email';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyEmailCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('تأكيد البريد الإلكتروني')),
        body: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال رابط التحقق')),
              );
              // Navigate to home category view after successful verification email sending
              Navigator.pushReplacementNamed(context, '/homecategory_view');
            } else if (state is VerifyEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'يرجى التحقق من بريدك الإلكتروني قبل تسجيل الدخول.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    state is VerifyEmailLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () => context
                                .read<VerifyEmailCubit>()
                                .sendVerificationEmail(context),
                            child: const Text('إعادة إرسال رابط التحقق'),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
