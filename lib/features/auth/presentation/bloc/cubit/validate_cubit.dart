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

  String? emailValidate(String? value) {
    if (value!.isEmpty) {
      return "The value must be not empty";
    } else if (!(value.contains('@') && value.contains('.com'))) {
      return "The value not email";
    } else {
      return null;
    }
  }

  String? passwordValidate(value) {
    if (value!.isEmpty) {
      return 'The password must be not empty';
      // LocaleKeys.auth_validate_password_empty.tr();
    } else if (value.length > 20 || value.length < 8) {
      return 'The password must be contains 8 - 20 ';
      // LocaleKeys.auth_validate_password_length.tr();
    }
    return null;
  }

// String? nameValidate(value, int nameType) {
//   if (value!.isEmpty) {
//     return nameType == 0
//         ? LocaleKeys.auth_validate_name_first_name_empty.tr()
//         : LocaleKeys.auth_validate_name_last_name_empty.tr();
//   } else if (value.length > 20 || value.length < 2) {
//     return nameType == 0
//         ? LocaleKeys.auth_validate_name_first_name_length.tr()
//         : LocaleKeys.auth_validate_name_last_name_length.tr();
//   }
//   return null;
// }
}
