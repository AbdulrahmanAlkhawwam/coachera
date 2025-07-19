import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/screen.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/params/change_password_param.dart';
import '../manager/bloc/auth_bloc.dart';
import '../manager/cubit/validate_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.passkey,
  });

  final String email;
  final String passkey;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _confirmPasswordController = TextEditingController();

  final _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateCubit>(
      create: (context) => ValidateCubit(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          var bloc = context.read<AuthBloc>();
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.status == AuthStatus.error) {
                context.showErrorSnackBar(massage: state.message);
              } else if (state.status == AuthStatus.success) {
                context.push(Routes.login);
              }
            },
            child: Screen(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () =>
                      Navigator.canPop(context) ? context.pop() : null,
                  icon: Icon(TablerIcons.chevron_left),
                ),
                title: Text(
                  'Reset Password',
                  style: context.textTheme.titleMedium,
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _key,
                  child: BlocBuilder<ValidateCubit, ValidateState>(
                    builder: (context, state) {
                      var cubit = context.read<ValidateCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                              'Please fill in the field below to reset your current password.',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.outline)),
                          const SizedBox(height: 32.0),
                          Text('Password',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.onSurface)),
                          const SizedBox(height: 8.0),
                          CustomInput(
                            onChanged: (value) => setState(() {}),
                            controller: _passwordController,
                            obscureText: cubit.isAppear,
                            validator: (value) => context
                                .read<ValidateCubit>()
                                .passwordValidate(value),
                            hint: "Password",
                            prefixIcon: TablerIcons.lock,
                            suffixIconButton: cubit.isAppear
                                ? TablerIcons.eye
                                : TablerIcons.eye_closed,
                            suffixFunctionButton: () => cubit.changeAppear(),
                          ),
                          const SizedBox(height: 32.0),
                          Text('Confirm Password',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.onSurface)),
                          const SizedBox(height: 8.0),
                          CustomInput(
                            onChanged: (value) => setState(() {}),
                            controller: _confirmPasswordController,
                            obscureText: cubit.isAppear,
                            validator: (value) => context
                                .read<ValidateCubit>()
                                .passwordValidate(value),
                            hint: "Rewrite Password",
                            prefixIcon: TablerIcons.lock,
                            suffixIconButton: cubit.isAppear
                                ? TablerIcons.eye
                                : TablerIcons.eye_closed,
                            suffixFunctionButton: () => cubit.changeAppear(),
                          ),
                          // const SizedBox(height: 16.0),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: TextButton(
                          //     onPressed: () {
                          //       // todo : don't forget to add forgot password logic
                          //     },
                          //     child: const Text('Forgot password?'),
                          //   ),
                          // ),
                          const SizedBox(height: 32.0),
                          FilledButton(
                            onPressed: bloc.state.status ==
                                        AuthStatus.loading ||
                                    _passwordController.text.compareTo(
                                            _confirmPasswordController.text) !=
                                        0
                                // TODO : when you have more time you should to make the login button disable when user don't input the data
                                // ||
                                // (context.read<ValidateCubit>().passwordValidate(
                                //             _passwordController.text) !=
                                //         null &&
                                //     context.read<ValidateCubit>().emailValidate(
                                //             _emailController.text) !=
                                //         null)
                                ? null
                                // : () {},
                                : () => _key.currentState!.validate()
                                    ? context
                                        .read<AuthBloc>()
                                        .add(ChangePassword(
                                            param: ChangePasswordParam(
                                          email: widget.email,
                                          passkey: widget.passkey,
                                          newPassword: _passwordController.text,
                                        )))
                                    : null,
                            child: bloc.state.status == AuthStatus.loading
                                ? CircularProgressIndicator()
                                : Text('Change Password'),
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
