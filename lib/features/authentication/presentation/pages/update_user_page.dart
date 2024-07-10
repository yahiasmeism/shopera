import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/data/models/user_model.dart';
import 'package:shopera/features/authentication/presentation/cubits/user_cubit/cubit.dart';
import 'package:shopera/features/authentication/presentation/widgets/text_form_field.dart';

class UpdateUserPage extends StatefulWidget {
  static const routeName = 'update_profile';
  const UpdateUserPage({super.key});

  @override
  State createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().userEntite;
    if (user != null) {
      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _usernameController.text = user.userName;
      _emailController.text = user.email;
      _phoneController.text = user.phone ?? '';
      _cityController.text = user.address?.city ?? '';
      _postalCodeController.text = user.address?.postalCode ?? '';
      _stateController.text = user.address?.state ?? '';
      _addressController.text = user.address?.address ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            // Auto Navigate to home or another page
          } else if (state is UserFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 45,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Update Profile',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(
                                    height: 45,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _firstNameController,
                                           label: 'First Name',
                                          
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                           type: TextInputType.text, 
                                           prefix: Icons.abc,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormFieldWidget (

                                          controller: _lastNameController,
                                           label: 'Last Name',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your last name';
                                            }
                                            return null;
                                          },
                                           type: TextInputType.text, 
                                           prefix: Icons.abc,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _usernameController,
                                           label: 'Username',
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a username';
                                            }
                                            return null;
                                          },
                                          type: TextInputType.text, 
                                           prefix: Icons.person,
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _emailController,
                                          label: 'Email',
                                           type: TextInputType.text, 
                                           prefix: Icons.email,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter an email';
                                            }
                                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                                .hasMatch(value)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _phoneController,
                                          label: 'Phone Number',
                                           type: TextInputType.text, 
                                           prefix: Icons.phone,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _cityController,
                                          label: 'City',
                                           type: TextInputType.text, 
                                           prefix: Icons.location_city,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a city';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _postalCodeController,
                                           label: 'Postal Code',
                                            type: TextInputType.text, 
                                           prefix: Icons.numbers,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a postal code';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormFieldWidget(
                                          controller: _stateController,
                                          label: 'State',
                                           type: TextInputType.text, 
                                           prefix: Icons.abc,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter a state';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormFieldWidget(
                                    controller: _addressController,
                                     label: 'Address',
                                      type: TextInputType.text, 
                                           prefix: Icons.add_home_work_sharp,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a address';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        // backgroundImage: profileImage == null
                        //     ? NetworkImage("${.image}")
                        //     : FileImage(profileImage) as ImageProvider,
                        radius: 60,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final user = context.read<UserCubit>().userEntite;
                              User updatedUser = User(
                                id: user?.id ?? 0,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                userName: _usernameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                image: user?.image,
                                address: Address(
                                    city: _cityController.text,
                                    postalCode: _postalCodeController.text,
                                    state: _stateController.text,
                                    address: '',
                                    coordinates: Coordinates(lat: 0, lng: 0)),
                                token: user?.token,
                              );
                              context
                                  .read<UserCubit>()
                                  .updateUser(user: updatedUser);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(color: Colors.white),
                            backgroundColor: Colors.teal,
                            // Text color
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8.0),
                              Text('Update'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _usernameController.clear();
                        _emailController.clear();
                        _firstNameController.clear();
                        _lastNameController.clear();
                        _phoneController.clear();
                        _cityController.clear();
                        _postalCodeController.clear();
                        _stateController.clear();
                        _addressController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _stateController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
