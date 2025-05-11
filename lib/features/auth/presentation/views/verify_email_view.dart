import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/auth/presentation/cubits/verify_email_state.dart/verify_email_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart'; // for correct route name

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  static const routeName = '/verify_email';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyEmailCubit()..startAutoRedirect(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('تأكيد البريد الإلكتروني')),
        body: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال رابط التحقق')),
              );
            } else if (state is VerifyEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<VerifyEmailCubit>();

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'يرجى التحقق من بريدك الإلكتروني قبل تسجيل الدخول.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    if (state is VerifyEmailLoading)
                      const CircularProgressIndicator(),

                    StreamBuilder<int>( 
                      stream: cubit.countdownController.stream,
                      builder: (context, snapshot) {
                        final countdown = snapshot.data ?? 0;
                        return countdown > 0
                            ? Text(
                                'إعادة إرسال رابط التحقق بعد: $countdown ثانية',
                                style: const TextStyle(fontSize: 16),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: (state is VerifyEmailLoading || state is VerifyEmailButtonDisabled)
                          ? null
                          : () {
                              cubit.stopAutoRedirect(); // Stop auto redirection when resending email
                              cubit.sendVerificationEmail(context);
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('إعادة إرسال رابط التحقق'),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SigninView.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('الذهاب إلى تسجيل الدخول'),
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
