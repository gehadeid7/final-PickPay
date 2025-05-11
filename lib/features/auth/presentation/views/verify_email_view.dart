import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickpay/features/auth/presentation/cubits/verify_email_state.dart/verify_email_cubit.dart';
import 'package:pickpay/features/auth/presentation/views/signin_view.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  static const routeName = '/verify_email';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => VerifyEmailCubit()..startAutoRedirect(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Verify Your Email'),
          backgroundColor:
              isDarkMode ? theme.appBarTheme.backgroundColor : Colors.white,
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          elevation: 1,
        ),
        body: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Verification link sent successfully'),
                  backgroundColor: theme.colorScheme.primary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            } else if (state is VerifyEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<VerifyEmailCubit>();

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mark_email_unread_outlined,
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Please verify your email address',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We\'ve sent a verification link to your email. Please check your inbox and click the link to verify your account.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    if (state is VerifyEmailLoading)
                      CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    StreamBuilder<int>(
                      stream: cubit.countdownController.stream,
                      builder: (context, snapshot) {
                        final countdown = snapshot.data ?? 0;
                        return countdown > 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  'Resend link in $countdown seconds',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (state is VerifyEmailLoading ||
                                state is VerifyEmailButtonDisabled)
                            ? null
                            : () {
                                cubit.stopAutoRedirect();
                                cubit.sendVerificationEmail(context);
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 2,
                        ),
                        child: const Text(
                          'Resend Verification Email',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SigninView.routeName);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          ),
                          foregroundColor: theme.colorScheme.primary,
                          elevation: 0,
                        ),
                        child: const Text(
                          'Back to Sign In',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
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




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pickpay/features/auth/presentation/cubits/verify_email_state.dart/verify_email_cubit.dart';
// import 'package:pickpay/features/auth/presentation/views/signin_view.dart';

// class VerifyEmailView extends StatelessWidget {
//   const VerifyEmailView({super.key});

//   static const routeName = '/verify_email';

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => VerifyEmailCubit()..startAutoRedirect(context),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('تأكيد البريد الإلكتروني')),
//         body: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
//           listener: (context, state) {
//             if (state is VerifyEmailSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('تم إرسال رابط التحقق')),
//               );
//             } else if (state is VerifyEmailFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.message)),
//               );
//             }
//           },
//           builder: (context, state) {
//             final cubit = context.read<VerifyEmailCubit>();

//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'يرجى التحقق من بريدك الإلكتروني قبل تسجيل الدخول.',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     const SizedBox(height: 20),
//                     if (state is VerifyEmailLoading)
//                       const CircularProgressIndicator(),

//                     StreamBuilder<int>( 
//                       stream: cubit.countdownController.stream,
//                       builder: (context, snapshot) {
//                         final countdown = snapshot.data ?? 0;
//                         return countdown > 0
//                             ? Text(
//                                 'إعادة إرسال رابط التحقق بعد: $countdown ثانية',
//                                 style: const TextStyle(fontSize: 16),
//                               )
//                             : const SizedBox.shrink();
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: (state is VerifyEmailLoading ||
//                               state is VerifyEmailButtonDisabled)
//                           ? null
//                           : () {
//                               cubit.stopAutoRedirect(); // Stop auto redirection when resending email
//                               cubit.sendVerificationEmail(context);
//                             },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text('إعادة إرسال رابط التحقق'),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushReplacementNamed(
//                             context, SigninView.routeName);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 24, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         backgroundColor: Colors.green,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text('الذهاب إلى تسجيل الدخول'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
