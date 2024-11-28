import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gofriendsgo/utils/color_theme/colors.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view/booking_screen/booking_screen.dart';
import 'package:gofriendsgo/view/chat_list.dart/chat_list.dart';
import 'package:gofriendsgo/view/home_screen/home_screen.dart';
import 'package:gofriendsgo/view/profile_screen/profile_editing_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PageController pageController = PageController();
  late List<Widget> pages;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomeScreen(),
      BookingDetailsScreen(
        fromBottomNav: true,
        pageController: pageController,
      ),
      ChatListScreen(
        fromBottomNav: true,
        //pageController: pageController,
      ),
      ProfileEditingScreen(
        pageController: pageController,
        onBack: null,
        fromBottomNav: true
      )
    ];
  }

  Widget _buildGradientIcon(IconData icon, bool isSelected) {
    return isSelected
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: AppColors.gradientColors,
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: Icon(
              icon,
              color: Colors.white,
            ),
          )
        : Icon(icon);
  }

  Widget _buildGradientSvgIcon(String asset, bool isSelected) {
    if (isSelected) {
      return ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            colors: AppColors.gradientColors,
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: SvgPicture.asset(
          asset,
        ),
      );
    } else {
      return SvgPicture.asset(
        asset,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.whiteColor,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.blackColor,
        unselectedItemColor: AppColors.blackColor,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Color.fromRGBO(94, 95, 96, 1)),
        onTap: (value) {
          setState(() {
            currentIndex = value;
            pageController.jumpToPage(value);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildGradientIcon(Icons.home_filled, currentIndex == 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildGradientSvgIcon(AppImages.bookings, currentIndex == 1),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: _buildGradientIcon(Icons.forum_outlined, currentIndex == 2),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: _buildGradientIcon(Icons.account_circle_outlined, currentIndex == 3),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
