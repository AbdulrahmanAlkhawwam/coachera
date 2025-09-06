import 'dart:io';
import 'package:coachera/core/components/Customer_date.dart';
import 'package:coachera/core/components/custom_input.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/auth/presentation/manager/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    context.read<AuthBloc>().add(GetMe());
    super.initState();
  }

  File? _image;
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final birthdayController = TextEditingController();

  Future<void> _pickImage() async {
    // final picker = ImagePicker();
    // final pickedFile = await picker.pickImage(source: ImageSource.camera);
    // if (pickedFile != null) {
    //   setState(() => _image = File(pickedFile.path));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          context.showErrorSnackBar(massage: state.message);
        } else if (state.status == AuthStatus.success) {
          final user = state.user;
          firstNameController.text = user?.firstName ?? "";
          lastNameController.text = user?.lastName ?? "";
          phoneController.text = user?.phoneNumber ?? "";
          locationController.text = user?.address ?? "";
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const Text("Personal Data"),
          centerTitle: false,
          actions: [
            IconButton(
              icon: const Icon(TablerIcons.check, color: Colors.teal),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Save logic here
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              _image != null ? FileImage(_image!) : null,
                          child: _image == null
                              ? const Icon(Icons.person,
                                  size: 60, color: Colors.grey)
                              : null,
                        ),
                        InkWell(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                            ),
                            child: const Icon(Icons.camera_alt,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInput(
                    icon: Icons.person,
                    controller: firstNameController,
                    label: "first name",
                  ),
                  _buildInput(
                    icon: Icons.person,
                    controller: lastNameController,
                    label: "last name",
                  ),
                  _buildInput(
                    icon: Icons.phone,
                    controller: phoneController,
                    label: "Phone Number",
                  ),
                  _buildInput(
                    icon: Icons.location_on,
                    controller: locationController,
                    label: "Location",
                  ),
                  BirthDatePicker(
                    onChanged: (p0) => print(p0),
                    initialDate: state.user?.birthDate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required IconData icon,
    required TextEditingController controller,
    required String label,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomInput(
        controller: controller,
        // enabled: enabled,
        // decoration: InputDecoration(
        //   labelText: label,
        prefixIcon: icon /*, color: Colors.teal),*/,
        suffixIcon: enabled ? null : /* const Icon(*/ Icons.check,
        /* color: Colors.teal),*/
        //   border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        //   filled: true,
        //   fillColor: Colors.grey.shade100,
        // ),
        validator: (value) =>
            value == null || value.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
