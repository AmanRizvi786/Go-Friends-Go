import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/view_model/carosual_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeCarosualWidget extends StatefulWidget {
  const HomeCarosualWidget({
    super.key,
    required this.adController,
  });

  final PageController adController;

  @override
  _HomeCarosualWidgetState createState() => _HomeCarosualWidgetState();
}

class _HomeCarosualWidgetState extends State<HomeCarosualWidget> {
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Initialize Timer for Auto-Scrolling
    _autoScrollTimer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < Provider.of<CarosualViewModel>(context, listen: false)
          .carouselsModel!
          .data
          .length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      widget.adController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Cancel Timer when the widget is disposed
    _autoScrollTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: mediaqueryheight(0.03, context),),
        SizedBox(
          width: mediaquerywidth(0.95, context),
          height: mediaqueryheight(0.23, context),
          child: Consumer<CarosualViewModel>(
            builder: (context, carosualViewModel, child) {
              if (carosualViewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return PageView.builder(
                  controller: widget.adController,
                  itemCount: carosualViewModel.carouselsModel!.data.length,
                  itemBuilder: (context, index) {
                    final carosuals = carosualViewModel.carouselsModel!.data[index];
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: API.baseImageUrl + carosuals.image,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Image.asset(AppImages.goFriendsGoLogo),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}