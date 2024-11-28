import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gofriendsgo/model/user_model/user_details_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/app_button.dart';
import 'package:gofriendsgo/utils/constants/app_textfields.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/login_screen/login_screen.dart';
import 'package:gofriendsgo/view/otp_verify_screen/otp_screen.dart';
import 'package:gofriendsgo/view_model/user_details.dart';
import 'package:gofriendsgo/widgets/signup_widget/custom_field.dart';
import 'package:gofriendsgo/widgets/signup_widget/drop_down.dart';
import 'package:gofriendsgo/widgets/signup_widget/sign_text.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _refferelController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: commonScreenPadding(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomSizedBoxHeight(0.1),
                    const AppdecorText(
                      text: 'Sign Up',
                      size: 0.08,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    const CustomSizedBoxHeight(0.05),

                    // Name Field with Icon and Divider
                    _buildCustomTextField(
                      label: 'Name',
                      controller: _nameController,
                      hintText: 'Enter your Name',
                      icon: Icons.account_circle_outlined,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),

                    // Email Field with Icon and Divider
                    _buildCustomTextField(
                      label: 'Email Address',
                      controller: _emailController,
                      hintText: 'Enter your Email Address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegExp = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBoxHeight(0.02),

                    // Referral Code Field with Icon and Divider
                    _buildCustomTextField(
                      label: 'Referral Code',
                      controller: _refferelController,
                      hintText: '12FDFVD',
                      icon: Icons.tag,
                    ),
                    const CustomSizedBoxHeight(0.02),
                    StaticDropdownField(),
                    const CustomSizedBoxHeight(0.02),

                    // Additional Information if Source is "Other"
                    Consumer<UserViewModel>(
                      builder: (context, value, child) {
                        if (value.sourceController == 'Other') {
                          return InputField.inputField(
                            controller: _reasonController,
                            maxLength: 500,
                            hinttext: 'From where you heard about us',
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              //const CustomSizedBoxHeight(0.09),
              Column(
                children: [
                  const CustomSizedBoxHeight(0.10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignUpText(
                        onTapLogin: () {
                          PageNavigations().push(LoginScreen());
                        },
                      ),
                    ],
                  ),
                  const CustomSizedBoxHeight(0.015),
                  // CustomButton(
                  //   function: () async {
                  //     if (_signUpFormKey.currentState!.validate()) {
                  //       _sourceController.text = userViewModel.sourceController;
                  //
                  //       UserDetails userDetails = UserDetails(
                  //         name: _nameController.text,
                  //         email: _emailController.text,
                  //         role: 'user',
                  //         referral: _refferelController.text.isEmpty
                  //             ? null
                  //             : _refferelController.text,
                  //         source: _sourceController.text,
                  //       );
                  //
                  //       // Attempt to register user
                  //       bool isSuccess = await userViewModel.registerUser(userDetails);
                  //
                  //       // Check if registration was successful
                  //       if (isSuccess) {
                  //         PageNavigations().push(OtpVerifyScreen(
                  //           signUpEmail: _emailController.text,
                  //           signUpName: _nameController.text,
                  //           userDetails: userDetails,
                  //         ));
                  //       } else {
                  //         // Handle the error message in case of failure
                  //         Get.snackbar(
                  //           "Error",
                  //           userViewModel.message ?? 'Registration failed, please try again',
                  //           backgroundColor: Colors.red.shade400,
                  //           colorText: Colors.white,
                  //         );
                  //       }
                  //     }
                  //   },
                  //   text: 'Get OTP',
                  //   fontSize: 0.04,
                  //   buttonTextColor: AppColors.whiteColor,
                  //   borderColor: Colors.transparent,
                  //   fontFamily: CustomFonts.poppins,
                  // ),
                  CustomButton(
                    function: () async {
                      if (_signUpFormKey.currentState!.validate()) {
                        _sourceController.text = userViewModel.sourceController;

                        UserDetails userDetails = UserDetails(
                          name: _nameController.text,
                          email: _emailController.text,
                          role: 'user',
                          referral: _refferelController.text.isEmpty
                              ? null
                              : _refferelController.text,
                          source: _sourceController.text,
                        );

                        // Attempt to register user
                        bool isSuccess = await userViewModel.registerUser(userDetails);

                        // If registration is successful, proceed to OTP verification
                        if (isSuccess) {
                          PageNavigations().push(OtpVerifyScreen(
                            signUpEmail: _emailController.text,
                            signUpName: _nameController.text,
                            userDetails: userDetails,
                          ));
                        }
                        // If registration failed, the error message will be shown by the service
                      }
                    },
                    text: 'Get OTP',
                    fontSize: 0.04,
                    buttonTextColor: AppColors.whiteColor,
                    borderColor: Colors.transparent,
                    fontFamily: CustomFonts.poppins,
                  ),

                  const CustomSizedBoxHeight(0.05),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create a custom text field with icon and divider
  Widget _buildCustomTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatter,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontFamily: CustomFonts.poppins,
          text: label,
          size: 0.04,
          color: Colors.black,
        ),
        const CustomSizedBoxHeight(0.01),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 24,
                width: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatter,
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
