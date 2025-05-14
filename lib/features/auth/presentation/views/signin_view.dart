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
        // إظهار حوار تأكيد عند العودة
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('هل أنت متأكد؟'),
            content: Text('هل ترغب في الخروج من التطبيق؟'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // لا للخروج
                },
                child: Text('لا'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true); // نعم للخروج
                },
                child: Text('نعم'),
              ),
            ],
          ),
        ) ??
            false; // إذا ضغط على أي مكان آخر، يتم إلغاء العملية
      },
      child: BlocProvider(
        create: (context) => SigninCubit(
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          appBar: buildAppBar(context: context, title: 'تسجيل الدخول'),
          body: SigninViewBodyBlocConsumer(),
        ),
      ),
    );
  }
}
