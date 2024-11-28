import 'package:flutter/material.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';

class BookingDetailsAppbar extends StatelessWidget {
  final void Function() onBack;
  final bool showBackButton; // Add this parameter

  const BookingDetailsAppbar({super.key, required this.onBack, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientColors,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: commonScreenPadding(context),
        child: Column(
          children: [
           // const CustomSizedBoxHeight(0.01),
            const CustomSizedBoxHeight(0.02),
            Row(
              children: [
                // Conditionally show the back button
                if (showBackButton)
                  IconButton(
                    iconSize: mediaquerywidth(0.08, context),
                    onPressed: () {
                      onBack();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.whiteColor,
                    ),
                  ),
                if (showBackButton)
                  const CustomSizedBoxWidth(0.02),
                const CustomText(
                  weight: FontWeight.bold,
                  text: "Bookings",
                  fontFamily: CustomFonts.roboto,
                  size: 0.055,
                  color: AppColors.whiteColor,
                ),
                const CustomSizedBoxHeight(0.085),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
