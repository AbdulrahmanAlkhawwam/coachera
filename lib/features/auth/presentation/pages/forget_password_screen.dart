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

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

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
              print(state.status);
              // todo : don't forget to show massage when the status is error
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
                  key: _key,
                  child: BlocBuilder<ValidateCubit, ValidateState>(
                    builder: (context, state) {
                      var cubit = context.read<ValidateCubit>();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                          FilledButton(
                            onPressed: bloc.state.status == AuthStatus.loading
                                // TODO : when you have more time you should to make the login button disable when user don't input the data
                                ||
                                (context
                                    .read<ValidateCubit>()
                                    .emailValidate(
                                    _emailController.text) !=
                                    null)
                                ? null
                                : () =>
                            _key.currentState!.validate()
                                ? print("send code")
                                : null,
                            child: bloc.state.status == AuthStatus.loading
                                ? CircularProgressIndicator(
                              color: context.colors.outline,
                              constraints:
                              BoxConstraints.tight(Size(24, 24)),
                            )
                                : Text('Email Me the Code'),
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
