import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/constants/routes.dart';
import 'package:coachera/core/constants/strings.dart';
import 'package:coachera/features/auth/domain/params/register_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/Customer_date.dart';
import '../../../../core/components/custom_input.dart';
import '../../../../core/components/gender_selector.dart';
import '../../../../core/components/phone_input.dart';
import '../../../../core/utils/app_context.dart';
import '../../../../core/components/screen.dart';
import '../manager/bloc/auth_bloc.dart';
import '../manager/cubit/validate_cubit.dart';

enum Gender { FEMALE, MALE }

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  DateTime birthdate = DateTime.now();
  late Gender gender;

  final _userNameController = TextEditingController();
  final _addressController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _passwordController = TextEditingController();
  final _educationController = TextEditingController();
  final phoneController = TextEditingController();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

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
            },
            child: Screen(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () =>
                      Navigator.canPop(context) ? context.pop() : null,
                  // todo : don't forget to fix this in the future
                  icon: Icon(TablerIcons.chevron_left),
                ),
                title: Text(
                  'Create Account',
                  style: context.textTheme.titleMedium,
                ),
              ),
              body: Form(
                key: _key,
                child: BlocBuilder<ValidateCubit, ValidateState>(
                  builder: (context, state) {
                    var cubit = context.read<ValidateCubit>();
                    return Column(
                      children: [
                        Expanded(
                          child: BoundedList(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: <Widget>[
                              Text(
                                  'Enjoy the various best course we have, choose the category according to your wishes.',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.outline)),
                              const SizedBox(height: 32.0),
                              Text('username',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: _userNameController,
                                keyboardType: TextInputType.text,
                                hint: 'User Name',
                                prefixIcon: TablerIcons.at,
                                validator: (value) => cubit.nameValidate(value),
                              ),
                              Text('first Name',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: firstNameController,
                                keyboardType: TextInputType.text,
                                hint: 'first Name',
                                prefixIcon: TablerIcons.user,
                                validator: (value) => cubit.nameValidate(value),
                              ),
                              Text('last Name',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: lastNameController,
                                keyboardType: TextInputType.text,
                                hint: 'last Name',
                                prefixIcon: TablerIcons.user,
                                validator: (value) => cubit.nameValidate(value),
                              ),
                              Text('education',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: _educationController,
                                keyboardType: TextInputType.text,
                                hint: 'education',
                                prefixIcon: TablerIcons.school,
                                validator: (value) => cubit.nameValidate(value),
                              ),
                              Text('Gender',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              GenderSelector(
                                initialGender: "male",
                                onChanged: (gender) {
                                  gender == "male"
                                      ? this.gender = Gender.MALE
                                      : Gender.FEMALE;
                                },
                              ),
                              Text('birthdate',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              BirthDatePicker(
                                initialDate: birthdate,
                                onChanged: (date) {
                                  if (date != null) {
                                    birthdate = date;
                                  }
                                },
                              ),

                              // const SizedBox(height: 32.0),
                              Text('Email',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                hint: 'Example@email.com',
                                prefixIcon: TablerIcons.mail,
                                validator: (value) =>
                                    cubit.validateEmail(value),
                              ),
                              Text('Address',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              CustomInput(
                                controller: _addressController,
                                keyboardType: TextInputType.streetAddress,
                                hint: 'Enter Your Address',
                                prefixIcon: TablerIcons.map,
                                validator: (value) => cubit.nameValidate(value),
                              ),
                              Text('phone Number',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
                              const SizedBox(height: 8.0),
                              PhoneNumberField(
                                controller: phoneController,
                                onChanged: (val) {},
                              ),
                              // const SizedBox(height: 32.0),
                              Text('Password',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
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
                                suffixFunctionButton: () =>
                                    cubit.changeAppear(),
                              ),
                              // const SizedBox(height: 32.0),
                              Text('Confirm Password',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.onSurface)),
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
                                suffixFunctionButton: () =>
                                    cubit.changeAppear(),
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
                              // const SizedBox(height: 32.0),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: FilledButton(
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
                                    ? context.read<AuthBloc>().add(Register(
                                        param: RegisterParam(
                                            studentParam: RegisterStudentParam(
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              gender: gender.name,
                                              address: _addressController.text,
                                              birthDate: birthdate,
                                              education:
                                                  _educationController.text,
                                              phoneNumber: phoneController.text,
                                            ),
                                            userParam: RegisterUserParam(
                                              name: _userNameController.text,
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ))))
                                    : null,
                            child: bloc.state.status == AuthStatus.loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: context.colors.outline,
                                      constraints:
                                          BoxConstraints.tight(Size(24, 24)),
                                    ),
                                  )
                                : Center(child: Text('Create Account')),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // OutlinedButton(
                        //   // TODO : don't for get to add google sign in method
                        //   onPressed: null,
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       SvgPicture.asset(
                        //         Res.google,
                        //         width: 32,
                        //       ),
                        //       Text('Continue With Google'),
                        //     ],
                        //   ),
                        // ),
                        // const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already have an account? ",
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: context.colors.outline)),
                            TextButton(
                              onPressed: () =>
                                  context.pushReplacement(Routes.login),
                              child: Text('Login',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.colors.primary)),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                context.bottomPadding + context.bottomInsets),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
