import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/screen.dart';
import '../../../../core/constants/res.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/params/login_param.dart';
import '../bloc/bloc/auth_bloc.dart';
import '../bloc/cubit/validate_cubit.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateCubit>(
      create: (context) => ValidateCubit(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          var bloc = context.read<AuthBloc>();
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              print(state.status);
            },
            child: Screen(
              appBar: AppBar(
                title: Text(
                  'Login',
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
                          Text('Hello, Welcome back to coachera',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.outline)),
                          const SizedBox(height: 32.0),
                          Text('Email',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.onSurface)),
                          const SizedBox(height: 8.0),
                          CustomInput(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: 'Email Account',
                            prefixIcon: TablerIcons.mail,
                            validator: (value) => cubit.emailValidate(value),
                          ),
                          const SizedBox(height: 32.0),
                          const SizedBox(height: 32.0),
                          Text('Password',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.onSurface)),
                          const SizedBox(height: 8.0),
                          CustomInput(
                            controller: _passwordController,
                            isAppear: cubit.isAppear,
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
                          const SizedBox(height: 16.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // todo : don't forget to add forgot password logic
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          FilledButton(
                            onPressed: bloc.state.status == AuthStatus.loading
                                // TODO : when you have more time you should to make the login button disable when user don't input the data
                                // ||
                                // (context.read<ValidateCubit>().passwordValidate(
                                //             _passwordController.text) !=
                                //         null &&
                                //     context.read<ValidateCubit>().emailValidate(
                                //             _emailController.text) !=
                                //         null)
                                ? null
                                : () => _key.currentState!.validate()
                                    ? context.read<AuthBloc>().add(Login(
                                            param: LoginParam(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        )))
                                    : null,
                            child: bloc.state.status == AuthStatus.loading
                                ? CircularProgressIndicator(
                                    color: context.colors.outline,
                                    constraints:
                                        BoxConstraints.tight(Size(24, 24)),
                                  )
                                : Text('Login'),
                          ),
                          const SizedBox(height: 24.0),
                          OutlinedButton(
                            // TODO : don't for get to add google sign in method
                            onPressed: null,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Res.google),
                                Text('Vie Google'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don't have an account? ",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.outline)),
                              TextButton(
                                onPressed: () {
                                  // todo : don't forget to add sign in logic
                                },
                                child: Text('Sign in',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                            color: context.colors.primary)),
                              ),
                            ],
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
