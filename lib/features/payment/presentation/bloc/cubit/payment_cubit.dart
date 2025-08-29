import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(InitState());

  // bool isAppear = true;

  emitState() {
    emit(ChangeState());
  }

   String? validateCardNumber(String? input) {
    if (input == null || input.isEmpty) return 'Card number is required';

    String number = input.replaceAll(' ', '');
    if (!RegExp(r'^\d{13,19}$').hasMatch(number)) {
      return 'Card number must be 13-19 digits';
    }

    // Luhn check
    int sum = 0;
    bool alternate = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int n = int.parse(number[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    if (sum % 10 != 0) return 'Invalid card number';
    return null; // valid
  }

  String? validateCVV(String? input) {
    if (input == null || input.isEmpty) return 'CVV is required';
    if (!RegExp(r'^\d{3,4}$').hasMatch(input))
      return 'CVV must be 3 or 4 digits';
    return null;
  }

   String? validateExpiry(String? input) {
    if (input == null || input.isEmpty) return 'Expiry date is required';
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(input))
      return 'Expiry must be MM/YY';

    final parts = input.split('/');
    int month = int.parse(parts[0]);
    int year = int.parse(parts[1]) + 2000;

    if (month < 1 || month > 12) return 'Invalid month';

    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0);
    if (!expiryDate.isAfter(now)) return 'Card has expired';

    return null; // valid
  }

  String? validateAddress(String? input) {
    if (input == null || input.trim().isEmpty) {
      return 'Billing address is required';
    }
    if (input.trim().length < 5) {
      return 'Billing address is too short';
    }
    return null; // valid
  }
}
