// import 'package:flutter/material.dart';
// import 'package:gofriendsgo/model/cab_rates_model.dart';
// import 'package:gofriendsgo/utils/color_theme/colors.dart';
// import 'package:gofriendsgo/utils/constants/custom_text.dart';
// import 'package:gofriendsgo/utils/constants/paths.dart';
//
//
// class ExtraNoteInCabRates extends StatelessWidget {
//   const ExtraNoteInCabRates({
//     super.key,
//     required this.serviceDetails,
//   });
//
//   final CabRatesModel serviceDetails;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//           color: AppColors.backgroundColor),
//       child: CustomText(
//           text: serviceDetails.extraNote,
//           fontFamily: CustomFonts.roboto,
//           size: 0.028,
//           color: const Color.fromRGBO(0, 0, 0, 0.8)),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/cab_rates_model.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/custom_text.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class ExtraNoteInCabRates extends StatelessWidget {
  const ExtraNoteInCabRates({
    super.key,
  });

  //final CabRatesModel serviceDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaquerywidth(0.9, context),
      height: mediaqueryheight(0.05, context),

      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: Align(
        alignment: AlignmentDirectional.center,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "NOTE - MINIMUM ",
                style: TextStyle(
                  fontFamily: CustomFonts.roboto,
                  fontSize: MediaQuery.of(context).size.width * 0.033,
                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
              TextSpan(
                text: "200 KM",
                style: TextStyle(
                  fontFamily: CustomFonts.roboto,
                  fontSize: MediaQuery.of(context).size.width * 0.033,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
              TextSpan(
                text: " CHARGE FOR ONE DAY, \nTOLL PARKING AND NIGHT CHARGE EXTRA",
                style: TextStyle(
                  fontFamily: CustomFonts.roboto,
                  fontSize: MediaQuery.of(context).size.width * 0.033,
                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
