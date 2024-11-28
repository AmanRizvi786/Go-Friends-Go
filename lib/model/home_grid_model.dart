import 'package:gofriendsgo/utils/constants/app_strings.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';

class HomeGrid {
  final String imagePath;
  final String titleText;
  final String subText;

  HomeGrid(
      {required this.imagePath,
      required this.titleText,
      required this.subText});
}

List<HomeGrid> homeGridItems = [
  HomeGrid(
      imagePath: 'assets/images/gridImage.png',
      titleText: 'Fixed Departure',
      subText: TextStrings.homeGridFirstSubText),
  HomeGrid(
      imagePath: 'assets/images/passport.png',
      titleText: 'Passport checklist',
      subText: TextStrings.homeGridSecondSubText),
  HomeGrid(
      imagePath: 'assets/images/visacheck.png',
      titleText: 'Visa checklist',
      subText: TextStrings.homeGridThirdSubText),
  HomeGrid(
      imagePath: AppImages.car,
      titleText: 'Cab rates',
      subText: TextStrings.homeGridFourthText),
];
