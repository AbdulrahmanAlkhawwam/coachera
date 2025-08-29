part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class InitState extends PaymentState {}
final class ChangeState extends PaymentState {}
