import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/payment/presentation/bloc/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/service_locator/service_locator.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

void showStripePaymentBottomSheet(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final addressController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (_) {
      return BlocProvider<PaymentCubit>(
        create: (context) => sl.get<PaymentCubit>(),
        lazy: false,
        child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            var cubit = context.read<PaymentCubit>();
            return Padding(
              padding: EdgeInsets.only(
                bottom: context.bottomPadding + context.bottomInsets,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomInput(
                        controller: nameController,
                        keyboardType: TextInputType.number,
                        hint: 'Card Number',
                        validator: (value) => cubit.validateCardNumber(value),
                        // onChanged: (value) => cubit.emitState(),
                        prefixIcon: TablerIcons.credit_card,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomInput(
                              hint: "Expiry Date (MM/YY)",
                              controller: expiryController,
                              prefixIcon: TablerIcons.calendar,
                              keyboardType: TextInputType.datetime,
                              validator: (value) => cubit.validateExpiry(value),
                              // onChanged: (value) => cubit.emitState(),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: CustomInput(
                              controller: cvvController,
                              hint: "CVV",
                              prefixIcon: TablerIcons.lock_password,
                              keyboardType: TextInputType.number,
                              validator: (value) => cubit.validateCVV(value),
                              // onChanged: (value) => cubit.emitState(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomInput(
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                        hint: 'Billing Address',
                        validator: (value) => cubit.validateAddress(value),
                        // onChanged: (value) => cubit.emitState(),
                        prefixIcon: TablerIcons.map,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              // final paymentMethod = await Stripe.instance.createPaymentMethod(
                              //   PaymentMethodParams.card(
                              //     paymentMethodData: PaymentMethodData(
                              //       billingDetails: BillingDetails(
                              //         name: nameController.text,
                              //         email: emailController.text,
                              //         address: addressController.text.isNotEmpty
                              //             ? Address(line1: addressController.text)
                              //             : null,
                              //       ),
                              //     ),
                              //   ),
                              // );

                              // TODO: Send paymentMethod.id to your backend to complete payment
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Payment method created successfully!")),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Error: $e")),
                              );
                            }
                          }
                        },
                        child: Text("Pay Now"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
