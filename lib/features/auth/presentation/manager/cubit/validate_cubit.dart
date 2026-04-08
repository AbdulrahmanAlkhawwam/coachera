import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'validate_state.dart';

class ValidateCubit extends Cubit<ValidateState> {
  ValidateCubit() : super(InitState());
  bool isAppear = true;

  changeAppear() {
    isAppear = !isAppear;
    emit(ChangeState());
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    value = value.trim();

    if (value.length > 254) {
      return 'Email is too long';
    }

    if (value.contains(' ')) {
      return 'Email must not contain spaces';
    }

    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    final disposableDomains = [
      'mailinator.com',
      'tempmail.com',
      '10minutemail.com'
    ];
    final domain = value.split('@').last;
    if (disposableDomains.contains(domain.toLowerCase())) {
      return 'Disposable email addresses are not allowed';
    }
    return null;
  }

  String? passwordValidate(value) {
    if (value!.isEmpty) {
      return 'The password must be not empty';
    } else if (value.length > 20 || value.length < 8) {
      return 'The password must be contains 8 - 20 ';
    }
    return null;
  }

  String? nameValidate(value) {
    if (value!.isEmpty) {
      return "The name must be not empty";
    } else if (value.length > 20 || value.length < 2) {
      return "The name must be contains 2 - 20 ";
    }
    return null;
  }
}
