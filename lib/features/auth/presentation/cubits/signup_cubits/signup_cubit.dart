import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/user_entity.dart';
import 'signup_state.dart'; 

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
}
