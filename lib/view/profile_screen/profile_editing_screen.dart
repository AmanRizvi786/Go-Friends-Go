import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/constants/text_controllers.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/app_bar.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/date_of_birth.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/marriage_anniversary.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/profile_edit_button.dart';
import 'package:gofriendsgo/widgets/profile_wdigets/save_button.dart';
import 'package:gofriendsgo/widgets/signup_widget/custom_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class ProfileEditingScreen extends StatefulWidget {
  final PageController? pageController;
  final bool fromBottomNav ;
  const ProfileEditingScreen({super.key, required this.pageController, required onBack, required this.fromBottomNav});


  @override
  _ProfileEditingScreenState createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<ProfileViewModel>().fetchProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Fetch data from the provider
      final profileViewModel =
      Provider.of<ProfileViewModel>(context, listen: false);
      profileViewModel.disposing();
      nameController.text = profileViewModel.userName ?? '';
      salesController.text = profileViewModel.specify ?? '';
      companyNameController.text = profileViewModel.companyName ?? '';
      emailController.text = profileViewModel.userEmail ?? '';

      mobileController.text = profileViewModel.userPhone ?? '';

      frequentController.text = profileViewModel.frequentFlyerNo ?? '';
      additionalController.text = profileViewModel.additionalDetails ?? '';
    });
    super.initState();
  }

  Future<void> _handleImageSelection(ProfileViewModel value) async {
    try {
      await value.pickImage();
    } on PlatformException catch (e) {
      if (e.code == 'already_active') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Image picker is already active. Please wait.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarProfile(context, onBack: ()=> Navigator.pop(context), fromBottomNav: widget.fromBottomNav),
      body: SafeArea(
        child: Padding(
          padding: commonScreenPadding(context),
          child: Consumer<ProfileViewModel>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Form(
                    key: profileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _handleImageSelection(value),
                          child: ProfileImageStack(value),
                        ),
                        const CustomSizedBoxHeight(0.02),
                        CustomText(
                          text: nameController.text,
                          fontFamily: CustomFonts.roboto,
                          size: 0.055,
                          color: AppColors.blackColor,
                          weight: FontWeight.w900,
                        ),
                        if (!value.onEditPressed)
                          ProfilepageeEditbutton(
                            ontap: () => value.editButtonPressed(),
                          ),
                        const CustomSizedBoxHeight(0.01),
                        LabeledInputField(
                          hintText: 'Name',
                          labelText: 'Name',
                          controller: nameController,
                          isEnabled: value.onEditPressed,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          hintText: 'Ankith Agira',
                          labelText: 'Sales Executive Name',
                          controller: salesController,
                          isEnabled: value.onEditPressed,
                        ),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          hintText: 'Ab2C Travels',
                          labelText: 'Company Name',
                          controller: companyNameController,
                          isEnabled: value.onEditPressed,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          hintText: 'Abc@gmail.com',
                          labelText: 'Email',
                          controller: emailController,
                          isEnabled: false,
                          suffix: const Icon(Icons.done_rounded,
                              color: AppColors.successIconColor),
                        ),
                        const CustomSizedBoxHeight(0.02),
                        const Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: 'Date of Birth',
                            size: 0.04,
                            color: AppColors.blackColor,
                          ),
                        ),
                        DateOfBirthContainer(value),
                        if (value.onEditPressed && value.dob == null)
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "this field is required",
                                style: TextStyle(color: Colors.red),
                              )),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          keyboardType: TextInputType.number,
                          hintText: 'Enter Mobile Number',
                          labelText: 'Mobile',
                          controller: mobileController,
                          isEnabled: value.onEditPressed,
                          textInputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validator: (value) {
                            if (value!.trim().isEmpty ||
                                !value.isPhoneNumber ||
                                value.length < 10) {
                              return "please enter a valid phone number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const CustomSizedBoxHeight(0.02),
                        const Align(
                          alignment: AlignmentDirectional.topStart,
                          child: CustomText(
                            fontFamily: CustomFonts.poppins,
                            text: 'Marriage anniversary',
                            size: 0.04,
                            color: AppColors.blackColor,
                          ),
                        ),
                        MarriageAnniversaryContainer(value),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          hintText: 'Enter the Flyer No',
                          labelText: 'Frequent Flyer No',
                          controller: frequentController,
                          isEnabled: value.onEditPressed,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const CustomSizedBoxHeight(0.02),
                        LabeledInputField(
                          hintText: 'Type your extra details here..',
                          labelText: 'Additional Details',
                          controller: additionalController,
                          maxlngths: 3,
                          isEnabled: value.onEditPressed,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "this field is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const CustomSizedBoxHeight(0.04),
                        SaveButtonProfile(value,
                            profileFormKey: profileFormKey),
                        const CustomSizedBoxHeight(0.04),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}