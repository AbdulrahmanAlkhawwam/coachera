import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/screen.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/params/forget_password_param.dart';
import '../manager/bloc/auth_bloc.dart';
import '../manager/cubit/validate_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateCubit>(
      create: (_) => ValidateCubit(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bloc = context.read<AuthBloc>();
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                context.showErrorSnackBar(massage: state.message);
              } else if (state.status == AuthStatus.success) {
                context.push(
                  Routes.validateOtp,
                  arguments: {'email': _emailController.text},
                );
              }
            },
            child: Screen(
              appBar: AppBar(
                title: Text(
                  'Reset Password',
                  style: context.textTheme.titleMedium,
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: BlocBuilder<ValidateCubit, ValidateState>(
                    builder: (context, validateState) {
                      final cubit = context.read<ValidateCubit>();
                      final isLoading = bloc.state.status == AuthStatus.loading;
                      final isEmailValid =
                          cubit.validateEmail(_emailController.text) == null;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 32),
                          Text(
                            'Email',
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: context.colors.onSurface),
                          ),
                          const SizedBox(height: 8),
                          CustomInput(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Email Account',
                            prefixIcon: TablerIcons.mail,
                            onChanged: (_) => setState(() {}),
                            validator: cubit.validateEmail,
                          ),
                          const SizedBox(height: 32),
                          FilledButton(
                            onPressed: !isLoading && isEmailValid
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      bloc.add(ForgetPassword(
                                        param: ForgetPasswordParam(
                                          email: _emailController.text,
                                        ),
                                      ));
                                    }
                                  }
                                : null,
                            child: isLoading
                                ? CircularProgressIndicator()
                                : const Text('Email Me the Code'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
