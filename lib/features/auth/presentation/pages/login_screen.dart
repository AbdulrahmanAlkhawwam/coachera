import 'package:coachera/core/components/language_dialog.dart';
import 'package:coachera/core/localization/keys.g.dart';
import 'package:coachera/core/utils/message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/screen.dart';
import '../../../../core/constants/routes.dart';
import '../../../../core/utils/app_context.dart';
import '../../domain/params/login_param.dart';
import '../manager/bloc/auth_bloc.dart';
import '../manager/cubit/validate_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
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
              } else if (state.status == AuthStatus.authorized) {
                context.pushReplacement(Routes.main, arguments: {
                  'page': 0
                }).then((value) => context.showSuccessSnackBar(
                        massage: Message(
                      title: LocaleKeys.messages_Login_title.tr(),
                      value: LocaleKeys.messages_Login_body.tr(),
                    )));
              }
            },
            child: Screen(
              appBar: AppBar(
                  title: Text(
                    LocaleKeys.screens_login_title.tr(),
                    style: context.textTheme.titleMedium,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async => await showDialog(
                        context: context,
                        builder: (context) => LanguageDialog(),
                      ),
                      icon: Icon(TablerIcons.world),
                    ),
                  ]),
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
                          Text(LocaleKeys.screens_login_body.tr(),
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.outline)),
                          const SizedBox(height: 32.0),
                          Text(LocaleKeys.screens_login_email_label.tr(),
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(color: context.colors.onSurface)),
                          const SizedBox(height: 8.0),
                          CustomInput(
                            onChanged: (value) => setState(() {}),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hint: LocaleKeys.screens_login_email_body.tr(),
                            prefixIcon: TablerIcons.mail,
                            validator: (value) => cubit.validateEmail(value),
                          ),
                          const SizedBox(height: 32.0),
                          Text(LocaleKeys.screens_login_password_label.tr(),
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
                            hint: LocaleKeys.screens_login_password_body.tr(),
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
                              onPressed: () =>
                                  context.push(Routes.forgotPassword),
                              child: Text(
                                LocaleKeys.screens_login_forget_password.tr(),
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: context.colors.onSurface),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32.0),
                          FilledButton(
                            onPressed: bloc.state.status !=
                                        AuthStatus.loading &&
                                    (context
                                                .read<ValidateCubit>()
                                                .validateEmail(
                                                    _emailController.text) ==
                                            null &&
                                        context
                                                .read<ValidateCubit>()
                                                .passwordValidate(
                                                    _passwordController.text) ==
                                            null)
                                ? () => _key.currentState!.validate()
                                    ? bloc.add(Login(
                                        param: LoginParam(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      )))
                                    : null
                                : null,
                            child: bloc.state.status == AuthStatus.loading
                                ? CircularProgressIndicator()
                                : Text(
                                    LocaleKeys.screens_login_login_button.tr()),
                          ),
                          const SizedBox(height: 24.0),
                          FilledButton(
                            onPressed: () =>
                                context.read<AuthBloc>().add(GuestLogin()),
                            child: Text(LocaleKeys.screens_login_guest.tr()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(LocaleKeys.screens_login_forget_message.tr(),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.outline)),
                              TextButton(
                                onPressed: () =>
                                    context.pushReplacement(Routes.register),
                                child: Text(
                                    LocaleKeys.screens_login_register.tr(),
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
